class Reward < ApplicationRecord
  belongs_to :rewardable, polymorphic: true
  has_many_attached :files

  validates :name, presence: true
end
