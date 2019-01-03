module Tries
  class Start
    def initialize(args)
      @task_id = args[:task_id]
      @attempt_id = args[:attempt_id]
      @name = args[:name]
    end

    def perform
      attempt = if @attempt_id.nil?
                  Attempts::Start.new(task_id: @task_id, name: "attempt for #{@name}").perform
                else
                  Attempt.find(@attempt_id)
                end

      try = attempt.tries.create(name: @name, task_id: attempt.task_id)
      try.add_new_time_period
    end
  end
end
