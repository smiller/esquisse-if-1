class TimePeriod < ApplicationRecord
  belongs_to :task
  belongs_to :attempt, optional: true
  belongs_to :phase, optional: true
  belongs_to :try, optional: true

  scope :running, -> { where(finishes: nil) }

  def close(time = Time.now)
    update(finishes: time)
  end
end
