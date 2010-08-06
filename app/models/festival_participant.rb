class FestivalParticipant < ActiveRecord::Base
  belongs_to :venue
  belongs_to :festival
end
