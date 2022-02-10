require 'rails_helper'

feature 'User can create an answer', %q{
  In order to post answer for a question
  As an authenticated user
  I'd like to be able to answer on question
}do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'adds answer to a question' do
      answer = create(:answer)

      fill_in 'Body', with: answer.body
      click_on 'Add answer'

      expect(page).to have_content 'Answer successfully aded!'
      expect(page).to have_content answer.body
    end
  
    scenario 'adds an answer with errors' do
      click_on 'Add answer'
  
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to add an answer' do
    visit question_path(question)
    fill_in 'Body', with: 'Answer'
    click_on 'Add answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
