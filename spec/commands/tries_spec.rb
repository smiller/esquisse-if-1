require "rails_helper"

RSpec.describe Tries do
  it "tries lifecycle, supplying attempt on create" do
    task = Tasks::Start.new(name: "First task").perform
    attempt = Attempts::Start.new(task_id: task.id, name: "First attempt").perform

    Tries::Start.new(attempt_id: attempt.id, name: "First try").perform

    expect(Try.count).to eq(1)
    try = Try.first

    expect(try.attempt).to eq(attempt)
    expect(try.task).to eq(task)
    time_period = try.time_periods.first
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil

    Tries::Pause.new(id: try.id).perform

    expect(try.time_periods.count).to eq(1)
    time_period = try.time_periods.first
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).not_to be_nil

    Tries::Resume.new(id: try.id).perform

    expect(try.time_periods.count).to eq(2)
    time_period = try.running_time_period
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil

    Tries::Finish.new(id: try.id).perform

    expect(try.time_periods.count).to eq(2)
    time_period = try.time_periods.last
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).not_to be_nil
  end

  it "tries lifecycle, not supplying attempt on create" do
    task = Tasks::Start.new(name: "First task").perform

    Tries::Start.new(task_id: task.id, name: "First try").perform

    expect(Try.count).to eq(1)
    try = Try.first

    expect(try.task).to eq(task)

    expect(Attempt.count).to eq(1)
    attempt = Attempt.first
    expect(try.attempt).to eq(attempt)

    time_period = try.time_periods.first
    expect(time_period.starts).not_to be_nil
    expect(time_period.finishes).to be_nil
  end
end
