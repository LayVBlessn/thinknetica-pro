# frozen_string_literal: true

require 'rails_helper'

feature 'User can mark the best answer', "
  In order to match the best answer
  As an author of question
  I'd like to be able to match the best answer
" do
  given!(:user) { create(:user) }
  given!(:user_two) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Author', js: true do
    background { sign_in(user) }

    scenario 'can match the best answer' do
      visit question_path(question)

      click_on 'Mark as the best answer'

      within '.best-answer' do
        expect(page).to have_content "★ #{answer.body}"
      end
    end

    scenario 'can match new best answer' do
      visit question_path(question)

      click_on 'Mark as the best answer'

      answer_two = create(:answer, user: user, question: question)

      click_on 'Mark as the best answer'

      within '.best-answer' do
        expect(page).to have_content "★ #{answer_two.body}"
      end
    end
  end

  describe 'Not author' do
    background { sign_in(user_two) }

    scenario 'tries to match the best answer' do
      visit question_path(question)

      expect(page).to_not have_content 'Mark as the best answer'
    end
  end
end
