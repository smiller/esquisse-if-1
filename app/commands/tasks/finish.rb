module Tasks
  class Finish
    def initialize(args)
      @id = args[:id]
    end

    def perform
      task = Task.find(@id)
      task.close_running_time_period
    end
  end
end