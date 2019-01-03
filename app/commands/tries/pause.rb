module Tries
  class Pause
    def initialize(args)
      @id = args[:id]
    end

    def perform
      try = Try.find(@id)
      try.close_running_time_period
    end
  end
end
