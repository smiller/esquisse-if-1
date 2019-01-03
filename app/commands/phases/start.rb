module Phases
  class Start
    def initialize(args)
      @task_id = args[:task_id]
      @attempt_id = args[:attempt_id]
      @kind = args[:kind]
    end

    def perform
      phase = if !@task_id.nil?
                task = Task.find(@task_id)
                task.phases.create(kind: @kind)
              elsif !@attempt_id.nil?
                attempt = Attempt.find(@attempt_id)
                attempt.phases.create(kind: @kind, task_id: attempt.task_id)
              end
      phase.add_new_time_period
      phase
    end
  end
end
