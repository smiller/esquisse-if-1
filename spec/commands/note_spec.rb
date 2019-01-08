require "rails_helper"

RSpec.describe Note do
  it "add note to task" do
    task = Tasks::Start.new(name: "First task").perform

    Notes::Add.new(task_id: task.id, name: 'note 1', description: 'attached to a task').perform

    expect(task.notes.count).to eq(1)

    note = task.notes.first
    expect(note.name).to eq('note 1')
  end

  it "add note to attempt" do
    task = Tasks::Start.new(name: "First task").perform
    attempt = task.attempts.create(name: 'First attempt')

    Notes::Add.new(attempt_id: attempt.id, name: 'note 2', description: 'attached to an attempt').perform

    expect(task.notes.count).to eq(0)
    expect(attempt.notes.count).to eq(1)

    note = attempt.notes.first
    expect(note.name).to eq('note 2')
  end

  it "add note to try" do
    task = Tasks::Start.new(name: "First task").perform
    attempt = task.attempts.create(name: "First attempt")
    try = Tries::Start.new(attempt_id: attempt.id, name: "First try").perform

    Notes::Add.new(try_id: try.id, name: 'note 3', description: 'attached to a try').perform

    expect(task.notes.count).to eq(0)
    expect(attempt.notes.count).to eq(0)
    expect(try.notes.count).to eq(1)

    note = try.notes.first
    expect(note.name).to eq('note 3')
  end

  it "add note to phase" do
    task = Tasks::Start.new(name: "First task").perform
    phase = Phases::Start.new(task_id: task.id, kind: 'troubleshooting').perform

    Notes::Add.new(phase_id: phase.id, name: 'note 1', description: 'attached to a phase').perform

    expect(task.notes.count).to eq(0)
    expect(phase.notes.count).to eq(1)

    note = phase.notes.first
    expect(note.name).to eq('note 1')
  end

end
