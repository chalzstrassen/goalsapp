require 'spec_helper'
require 'rails_helper'

feature "goal status" do
  before(:each) do
    setup
  end

  scenario "goal status defaults to incomplete" do
    visit(user_url(User.find_by(username: 'the_best')))
    expect(page).to have_content "Public goalz (incomplete)"
  end

  scenario "user cannot see other user's complete button" do
    log_in_as("potato")
    visit(user_url(User.find_by(username: 'the_best')))
    expect(page).not_to have_button("Complete")
  end

  scenario "user cann see their own complete button" do
    log_in_as("the_best")
    visit(user_url(User.find_by(username: 'the_best')))
    expect(page).to have_button("Complete")
  end

  scenario "user can complete their own goal" do
    log_in_as('the_best')
    visit(user_url(User.find_by(username: 'the_best')))
    click_button('complete Public goalz')
    expect(page).not_to have_button('complete Public goalz')
    expect(page).to have_content('Public goalz (completed)')
  end
end
