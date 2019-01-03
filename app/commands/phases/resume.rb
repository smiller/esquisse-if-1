module Phases
  class Resume
    def initialize(args)
      @id = args[:id]
    end

    def perform
      phase = Phase.find(@id)
      phase.add_new_time_period
    end
  end
end
