module Attempts
  class Resume
    def initialize(args)
      @id = args[:id]
    end

    def perform
      attempt = Attempt.find(@id)
      attempt.add_new_time_period
    end
  end
end
