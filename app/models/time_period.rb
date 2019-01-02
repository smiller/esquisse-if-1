class TimePeriod < ApplicationRecord
  belongs_to :task
  belongs_to :attempt
  belongs_to :phase
  belongs_to :try

end
