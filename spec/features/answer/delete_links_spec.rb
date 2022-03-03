# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete his links', "
  In order to delete link from an answer
  As an authenticated user
  I'd like to be able to delete a link
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'tries to delete his answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'Body'
    fill_in 'Link name', with: 'Vk'
    fill_in 'Url', with: 'https://vk.com'

    click_on 'Add answer'

    click_on 'Delete link on Vk'  

    expect(page).not_to have_content 'Vk'
  end
end
