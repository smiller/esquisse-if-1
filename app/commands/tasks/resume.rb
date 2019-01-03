module Tasks
  class Resume
    def initialize(args)
      @id = args[:id]
    end

    def perform
      task = Task.find(@id)
      task.add_new_time_period
    end
  end
end
