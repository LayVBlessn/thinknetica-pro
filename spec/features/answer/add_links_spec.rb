# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to answer', "
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:vk_url) { 'https://vk.com' }

  scenario 'User adds link when asks question', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'My answer'
    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: vk_url

    click_on 'Add answer'

    within '.answers' do
      expect(page).to have_link 'My gist', href: vk_url
    end
  end

  scenario 'User adds invalid link when asks question', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'My answer'
    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: 'ada'

    click_on 'Add answer'

    expect(page).to have_content 'Links url is invalid'
  end
end
