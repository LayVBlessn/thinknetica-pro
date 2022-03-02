# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  belongs_to :best_answer, class_name: 'Answer', foreign_key: 'best_answer_id', optional: true

  has_many :links, dependent: :destroy
  has_many_attached :files
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :title, :body, presence: true
end
