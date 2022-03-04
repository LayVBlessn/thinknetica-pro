require 'rails_helper'

feature 'User can add reward to question', %q{
  In order to give reward for best answers for my question
  As an question's author
  I'd like to be able to add reward
}do

  given(:user) { create(:user) }
  
  scenario 'User adds reward for question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'title'
    fill_in 'Body', with: 'body'
    fill_in 'Name', with: 'reward name'

    within '.reward' do
      attach_file 'File', "/home/layv/Pictures/Screenshot from 2022-01-16 02-57-43.png"
    end

    click_on 'Ask'

    expect(page).to have_content 'reward name'
    expect(page).to have_css("img[alt*='reward name picture']")
  end


end