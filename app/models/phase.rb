class Phase < ApplicationRecord
  include TimeKeeping

  belongs_to :task
  belongs_to :attempt, optional: true
  has_many :time_periods
end
