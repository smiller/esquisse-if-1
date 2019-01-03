module TimeKeeping
  extend ActiveSupport::Concern

  def add_new_time_period(time = Time.now)
    time_periods.create(starts: time)
  end

  def close_running_time_period(time = Time.now)
    running_time_period.close(time)
  end

  def running_time_period
    time_periods.running.first
  end
end
