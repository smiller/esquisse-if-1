module Phases
  class Finish
    def initialize(args)
      @id = args[:id]
    end

    def perform
      phase = Phase.find(@id)
      phase.close_running_time_period
    end
  end
end
