require "rails_helper"

RSpec.describe Tag do
  it "lists" do
    tag1 = Tag.create(name: "First tag")
    tag2 = Tag.create(name: "Second tag")

    actual = Tags::List.new.perform
    expect(actual.count).to eq(2)
    expect(actual.map(&:name)).to match_array([tag1.name, tag2.name])
  end
end
