class Task < ApplicationRecord
  include TimeKeeping

  has_many :time_periods
  has_many :attempts
  has_many :tries
end
