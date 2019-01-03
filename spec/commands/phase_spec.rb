require "rails_helper"

RSpec.describe Phase do
  it "phase lifecycle, on task" do
    task = Tasks::Start.new(name: "First task").perform

    Phases::Start.new(kind: 'troubleshooting', task_id: task.id).perform

    expect(Phase.count).to eq(1)
    phase = Phase.first

    expect(phase.task).to eq(task)
    expect(phase.kind).to eq('troubleshooting')

    time_period = phase.time_periods.first
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil

    Phases::Pause.new(id: phase.id).perform

    expect(phase.time_periods.count).to eq(1)
    time_period = phase.time_periods.first
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).not_to be_nil

    Phases::Resume.new(id: phase.id).perform

    expect(phase.time_periods.count).to eq(2)
    time_period = phase.running_time_period
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil

    Phases::Finish.new(id: phase.id).perform

    expect(phase.time_periods.count).to eq(2)
    time_period = phase.time_periods.last
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).not_to be_nil

  end

  it "phase lifecycle, on attempt" do
    task = Tasks::Start.new(name: "First task").perform
    attempt = task.attempts.create(name: "First attempt")
    Phases::Start.new(kind: 'troubleshooting', attempt_id: attempt.id).perform

    expect(Phase.count).to eq(1)
    phase = Phase.first

    expect(phase.task).to eq(attempt.task)
    expect(phase.attempt).to eq(attempt)
    expect(phase.kind).to eq('troubleshooting')

    time_period = phase.time_periods.first
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil
  end
end
