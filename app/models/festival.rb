class Festival < ActiveRecord::Base
  has_many :events
  has_many :festival_participants
  has_many :venues, :through => :festival_participants

  named_scope :current, :conditions => {:current => true}
  named_scope :mapp, :conditions => "short_name like 'mapp_%'", :order => 'created_at desc'

  validates_uniqueness_of :short_name

  def self.current_mapp
    self.current.mapp.first
  end

  def mapp?
    short_name =~ /^mapp_/
  end
end
