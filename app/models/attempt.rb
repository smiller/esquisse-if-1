class Attempt < ApplicationRecord
  include TimeKeeping

  belongs_to :task
  has_many :tries
  has_many :time_periods
  has_many :phases
end
