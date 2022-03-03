class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, format: URI::DEFAULT_PARSER.regexp[:ABS_URI]
end
