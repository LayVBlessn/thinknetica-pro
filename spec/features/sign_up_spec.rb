# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign up', "
  In order to ask questions
  As authenticated user
  I'd like to sign up
" do
  scenario 'Registered User tries to sign up' do
    user = create(:user)
    sign_up(user)

    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'Unregistered User tries to sign up' do
    user = build(:user)
    sign_up(user)

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'User tries to sign up with unmathced passwords' do
    visit new_user_registration_path

    fill_in 'Email', with: 'lol@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end
end
