require "rails_helper"

RSpec.describe Attempt do
  it "attempt lifecycle" do
    Tasks::Start.new(name: "First task").perform

    expect(Task.count).to eq(1)
    task = Task.first

    Attempts::Start.new(task_id: task.id, name: "First attempt").perform

    expect(Attempt.count).to eq(1)
    attempt = Attempt.first

    expect(attempt.time_periods.count).to eq(1)
    expect(attempt.task).to eq(task)
    time_period = attempt.time_periods.first
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil

    Attempts::Pause.new(id: attempt.id).perform

    expect(attempt.time_periods.count).to eq(1)
    time_period = attempt.time_periods.first
    expect(time_period.finishes).not_to be_nil

    Attempts::Resume.new(id: attempt.id).perform

    expect(attempt.time_periods.count).to eq(2)
    time_period = attempt.running_time_period
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil

    Attempts::Finish.new(id: attempt.id).perform

    expect(attempt.time_periods.count).to eq(2)
    time_period = attempt.time_periods.last
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).not_to be_nil

  end
end
