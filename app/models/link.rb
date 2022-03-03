class Link < ApplicationRecord
  GIST_URL = /gist.github.com/

  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, format: URI::DEFAULT_PARSER.regexp[:ABS_URI]

  def is_gist?
    url.match(GIST_URL) 
  end
end
