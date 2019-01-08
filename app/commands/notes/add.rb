module Notes
  class Add
    def initialize(args)
      @task_id = args[:task_id]
      @attempt_id = args[:attempt_id]
      @try_id = args[:try_id]
      @phase_id = args[:phase_id]
      @name = args[:name]
      @description = args[:description]
    end

    def perform
      notable = if !@task_id.nil?
                  Task.find(@task_id)
                elsif !@attempt_id.nil?
                  Attempt.find(@attempt_id)
                elsif !@try_id.nil?
                  Try.find(@try_id)
                elsif !@phase_id.nil?
                  Phase.find(@phase_id)
                else
                  raise ArgumentError('needs a task_id / attempt_id / try_id / phase_id')
                end
      notable.notes.create(name: @name, description: @description, set_at: Time.now)
    end
  end
end
