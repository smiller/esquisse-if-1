module Tasks
  class Start

    def initialize(args)
      @name = args[:name]
    end

    def perform
      task = Task.create(name: @name)
      task.add_new_time_period
      task
    end
  end
end
