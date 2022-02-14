require 'rails_helper'

feature 'User can delete a question', %q{
  In order to delete question from a community
  As an authenticated user
  I'd like to be able to delete a question
}do
  given(:user_one) { create(:user) }
  given(:user_two) { create(:user) }
  given!(:question) { create(:question, user: user_one) }

  describe 'Autheticated user' do
    scenario 'tries to delete his question' do
      sign_in(user_one)
      visit question_path(question)
      click_on 'Delete this question'

      expect(page).to have_content 'Question was successfully deleted'
    end

    scenario 'tries to delete others questions' do
      sign_in(user_two)
      visit question_path(question)

      expect(page).not_to have_content 'Delete this question'
    end
  end

  describe 'Unathenticated user' do
    scenario 'tries to delete questions' do
      visit question_path(question)

      expect(page).not_to have_content 'Delete this question'
    end
  end
end
