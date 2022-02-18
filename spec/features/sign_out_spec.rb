# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign out', "
  In order to end user session
  As an inauthentificated user
  I'd like to be able to sign out
" do
  scenario 'Registered user tries to sign out' do
    user = create(:user)
    sign_in(user)

    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
