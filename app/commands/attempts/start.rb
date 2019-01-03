module Attempts
  class Start
    def initialize(args)
      @task_id = args[:task_id]
      @name = args[:name]
    end

    def perform
      task = Task.find(@task_id)
      attempt = task.attempts.create(name: @name)
      attempt.add_new_time_period
    end
  end
end
