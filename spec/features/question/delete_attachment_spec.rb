# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete his attachments', "
  In order to delete attachment from an question
  As an authenticated user
  I'd like to be able to delete a attachment
" do
  given(:user) { create(:user) }

  scenario 'tries to delete his answer', js: true do
    sign_in(user)
    visit questions_path

    click_on 'Ask question'

    fill_in 'Title', with: 'Title'
    fill_in 'Body', with: 'Body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Ask'

    click_on 'Delete spec_helper.rb'

    expect(page).not_to have_content 'spec_helper.rb'
  end
end
