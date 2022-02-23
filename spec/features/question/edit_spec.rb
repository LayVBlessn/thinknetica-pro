require 'rails_helper'

feature 'User can edit his question', %q{
  In order to correct mistakes
  As an author of question
  I'd like to be able to edit my question
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:user2) { create(:user) }

  scenario 'Unauthenticated user can not edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit question'
  end

  describe 'Authenticated user' do
    scenario 'edits his question', js: true do
      sign_in user

      visit question_path(question)

      click_on 'Edit this question'

      within '.question' do
        fill_in 'Title', with: 'edited question title'
        fill_in 'Body', with: 'edited question body'
        click_on 'Save'

        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to have_content 'edited question title'
        expect(page).to have_content 'edited question body'
        expect(page).to_not have_selector 'textarea'
      end
    end

    # scenario 'edits his answer with errors', js: true do
    #   sign_in user

    #   visit question_path(question)
      
    #   click_on 'Edit'

    #   within '.answers' do
    #     fill_in 'Body', with: ''
    #     click_on 'Save'
    #   end

    #   expect(page).to have_content "Body can't be blank"
    # end

    # scenario "tries to edit other user's answer" do
    #   sign_in user2

    #   visit question_path(question)

    #   expect(page).not_to have_content 'Edit'
    # end
  end
end
