# frozen_string_literal: true

class Reward < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :question

  has_one_attached :file

  validates :name, presence: true
end
