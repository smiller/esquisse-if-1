class Attempt < ApplicationRecord
  belongs_to :task
  has_many :tries
  has_many :time_periods
end
