require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before(:each) do
    visit new_user_url
    fill_in 'username', :with => "the_best"
    fill_in 'password', :with => "coffee"
    click_on "Sign Up"
  end

  it "has a new user page" do
    visit(new_user_url)
    expect(page).to have_content "New User"
  end

  feature "fill out a new user form" do
    scenario "user is logged in after signup" do
      expect(page).to have_content "the_best"
    end
  end
end

feature "logging in" do
  before(:each) do
    create_user('the_best')
  end

  it "shows username on the homepage after login" do
    log_in_as('the_best')
  end

  it "does not show Log In link if user is logged in" do
    log_in_as('the_best')
    visit(root_url)
    expect(page).to_not have_content "Log In"
  end

  it "should display an error message if username does not exist" do
    visit(new_session_url)
    fill_in "username", with: "the_worst"
    fill_in "password", with: "orange_juice"
    click_on "Log In"
    expect(page).to have_content "Invalid username/password combination"
  end

end

feature "logging out" do
  before(:each) do
    user = User.new(username: "the_best", password: "coffee")
    user.save!
  end

  it "begins with logged out state" do
    visit(root_url)
    expect(page).to have_content "Log In"
  end


  it "doesn't show username on the homepage after logout" do
    visit(new_session_url)
    fill_in 'username', :with => "the_best"
    fill_in 'password', :with => "coffee"
    click_on "Log In"
    visit(root_url)
    click_on "Log Out"
    expect(page).to_not have_content "the_best"
  end

  it "shows signup and log in links if not logged in" do
    visit(root_url)
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Log In")
  end
end
