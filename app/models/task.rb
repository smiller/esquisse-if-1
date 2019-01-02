class Task < ApplicationRecord
  has_many :time_periods
  has_many :attempts
  has_many :tries
end
