module Tries
  class Resume
    def initialize(args)
      @id = args[:id]
    end

    def perform
      try = Try.find(@id)
      try.add_new_time_period
    end
  end
end
