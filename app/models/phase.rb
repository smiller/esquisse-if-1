class Phase < ApplicationRecord
  belongs_to :task
  belongs_to :attempt
  has_many :time_periods
end
