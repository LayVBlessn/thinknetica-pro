# frozen_string_literal: true

require 'rails_helper'

feature 'User can create an answer', "
  In order to post answer for a question
  As an authenticated user
  I'd like to be able to answer on question
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'adds answer to a question' do
      fill_in 'Body', with: 'Body'
      click_on 'Add answer'

      expect(page).to have_content 'Body'
    end

    scenario 'adds an answer with errors' do
      click_on 'Add answer'

      expect(page).to have_content "Body can't be blank"
    end

    scenario 'add answer with with attached file' do
      fill_in 'Body', with: 'Body'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Add answer'

      expect(page).to have_link 'spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb'
    end
  end

  scenario 'Unauthenticated user tries to add an answer' do
    visit question_path(question)

    fill_in 'answer_body', with: 'Answer'
    click_on 'Add answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
