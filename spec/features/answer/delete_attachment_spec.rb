# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete his attachments', "
  In order to delete attachment from an answer
  As an authenticated user
  I'd like to be able to delete a attachment
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'tries to delete his answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Body', with: 'Body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Add answer'

    click_on 'Delete spec_helper.rb'

    expect(page).not_to have_content 'spec_helper.rb'
  end
end
