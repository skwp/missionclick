# Extends all our models with some convenience methods for
# checking permissions. This provides one place to change
# behavior if we implement more complex auth logic like
# venues having access to their own pages.
#
module PermissionsModule
  
  def owned_by?(someone)
    self.respond_to?(:user) && self.user == someone
  end

  def editable_by?(someone)
    someone && (owned_by?(someone) || someone.admin?)
  end

end
ActiveRecord::Base.send(:include, PermissionsModule)
