module Tags
  class Add
    def initialize(args)
      @task_id = args[:task_id]
      @attempt_id = args[:attempt_id]
      @try_id = args[:try_id]
      @phase_id = args[:phase_id]
      @name = args[:name]
    end

    def perform
      taggable = if !@task_id.nil?
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

      tag = Tag.where(name: @name).first
      if tag.nil?
        tag = Tag.create(name: @name)
      end

      taggable.tag_links.create(tag_id: tag.id)
    end
  end
end
