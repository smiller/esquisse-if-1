module Attempts
  class Pause
    def initialize(args)
      @id = args[:id]
    end

    def perform
      attempt = Attempt.find(@id)
      attempt.close_running_time_period
    end
  end
end
