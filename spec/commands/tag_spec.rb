require "rails_helper"

RSpec.describe Tag do
  it "add existing tag to task" do
    task = Tasks::Start.new(name: "First task").perform
    existing_tag = Tag.create(name: "Existing tag")
    expect(Tag.count).to eq(1)
    Tags::Add.new(task_id: task.id, name: "Existing tag").perform
    expect(Tag.count).to eq(1)

    expect(task.tags.count).to eq(1)
    tag = task.tags.first
    expect(tag.name).to eq('Existing tag')
  end

  it "add new tag to task" do
    task = Tasks::Start.new(name: "First task").perform

    expect(Tag.count).to eq(0)
    Tags::Add.new(task_id: task.id, name: "New tag").perform
    expect(Tag.count).to eq(1)

    expect(task.tags.count).to eq(1)
    tag = task.tags.first
    expect(tag.name).to eq('New tag')
  end

  it "add tag to attempt" do
    task = Tasks::Start.new(name: "First task").perform
    attempt = task.attempts.create(name: 'First attempt')
    existing_tag = Tag.create(name: "Tag")

    Tags::Add.new(attempt_id: attempt.id, name: "Tag").perform

    expect(task.tags.count).to eq(0)
    expect(attempt.tags.count).to eq(1)
    tag = attempt.tags.first
    expect(tag.name).to eq('Tag')
  end

  it "add tag to try" do
    task = Tasks::Start.new(name: "First task").perform
    attempt = task.attempts.create(name: 'First attempt')
    try = Tries::Start.new(attempt_id: attempt.id, name: "First try").perform
    existing_tag = Tag.create(name: "Tag")

    Tags::Add.new(try_id: try.id, name: "Tag").perform

    expect(task.tags.count).to eq(0)
    expect(attempt.tags.count).to eq(0)
    expect(try.tags.count).to eq(1)
    tag = try.tags.first
    expect(tag.name).to eq('Tag')
  end

  it "add tag to phase" do
    task = Tasks::Start.new(name: "First task").perform
    phase = Phases::Start.new(task_id: task.id, kind: 'troubleshooting').perform
    existing_tag = Tag.create(name: "Tag")

    Tags::Add.new(phase_id: phase.id, name: "Tag").perform

    expect(task.tags.count).to eq(0)
    expect(phase.tags.count).to eq(1)
    tag = phase.tags.first
    expect(tag.name).to eq('Tag')
  end
end
