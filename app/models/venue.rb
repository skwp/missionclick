class Venue < ActiveRecord::Base
  has_many :events

  def to_s; name; end
  def to_param; "#{id}-#{name.parameterize}"; end
end
