class Festival < ActiveRecord::Base
  has_many :events

  named_scope :current, :conditions => {:current => true}
  named_scope :mapp, :conditions => "short_name like 'mapp_%'"

  validates_uniqueness_of :short_name

  def self.current_mapp
    self.current.mapp.first
  end

  def mapp?
    short_name =~ /^mapp_/
  end
end