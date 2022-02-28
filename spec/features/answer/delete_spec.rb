# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete an answer', "
  In order to delete answer from a community
  As an authenticated user
  I'd like to be able to delete an answer
" do
  given(:user_one) { create(:user) }
  given(:user_two) { create(:user) }
  given(:question) { create(:question, user: user_one) }
  given!(:answer) { create(:answer, question: question, user: user_one) }

  describe 'Autheticated user' do
    scenario 'tries to delete his answer', js: true do
      sign_in(user_one)
      visit question_path(question)
      click_on 'Delete this answer'

      expect(page).not_to have_content answer.body
    end

    scenario 'tries to delete others answers' do
      sign_in(user_two)
      visit question_path(question)

      expect(page).not_to have_content 'Delete this answer'
    end
  end

  describe 'Unathenticated user' do
    scenario 'tries to delete answers' do
      visit question_path(question)

      expect(page).not_to have_content 'Delete this answer'
    end
  end
end
