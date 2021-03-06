# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:rewards) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'Model methods' do
    let(:user_one) { create(:user) }
    let(:user_two) { build(:user) }
    let(:question) { create(:question, user: user_one) }
    let(:reward) { create(:reward, question: question) }
    let(:answer) { create(:answer, user: user_one) }

    it 'should determine user is an author of question and asnwer' do
      expect(user_one).to be_author_of(question)
      expect(user_one).to be_author_of(answer)
    end

    it 'should show that user is not an author of question and answer' do
      expect(user_two).not_to be_author_of(question)
      expect(user_two).not_to be_author_of(answer)
    end

    it 'should claim reward' do
      user_one.claim_reward(reward)

      expect(user_one.rewards).to eq [reward]
    end
  end
end
