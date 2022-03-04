# frozen_string_literal: true

require 'rails_helper'

feature 'User can claim reward', "
  In order to claim reward for best answer for question
  As an authenticated user
  I'd like to be able to claim reward
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:reward) { create(:reward, question: question) }

  scenario 'User claims reward', js: true do
    sign_in(user)

    visit question_path(question)

    click_on 'Mark as the best answer'

    visit rewards_path

    expect(page).to have_content question.title
    expect(page).to have_content reward.name
    expect(page).to have_css("img[alt*='MyReward picture']")
  end
end
