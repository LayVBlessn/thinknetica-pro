class Reward < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_one_attached :file

  validates :name, presence: true
end
