class Try < ApplicationRecord
  include TimeKeeping

  belongs_to :task
  belongs_to :attempt
  has_many :time_periods
  has_many :notes, as: :notable
  has_many :tag_links, as: :taggable
  has_many :tags, through: :tag_links
end
