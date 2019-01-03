require "rails_helper"

RSpec.describe Task do
  it "task lifecycle" do
    Tasks::Start.new(name: "First task").perform

    expect(Task.count).to eq(1)
    task = Task.first
    expect(task.time_periods.count).to eq(1)
    time_period = task.time_periods.first
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil

    Tasks::Pause.new(id: task.id).perform

    expect(task.time_periods.count).to eq(1)
    time_period = task.time_periods.first
    expect(time_period.finishes).not_to be_nil

    Tasks::Resume.new(id: task.id).perform

    expect(task.time_periods.count).to eq(2)
    time_period = task.running_time_period
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil

    Tasks::Finish.new(id: task.id).perform

    expect(task.time_periods.count).to eq(2)
    time_period = task.time_periods.last
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).not_to be_nil
  end
end
