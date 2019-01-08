class Task < ApplicationRecord
  include TimeKeeping

  has_many :time_periods
  has_many :attempts
  has_many :tries
  has_many :phases
  has_many :notes, as: :notable
  has_many :tag_links, as: :taggable
  has_many :tags, through: :tag_links
end
