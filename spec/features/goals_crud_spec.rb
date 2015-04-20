require 'spec_helper'
require 'rails_helper'

feature "CRUD feature for goals" do
  before(:each) do
    setup
  end

  feature "create posts" do
    scenario "users can create posts" do
      log_in_as("the_best")
      visit(new_goal_url)
      fill_in('Body', with: "Continue to be the best easily")
      fill_in('Title', with: "Easy goal")
      choose('Private')
      choose('Public')
      click_on("Submit Goal")
      visit(user_url(User.find_by(username:"the_best")))
      expect(page).to have_content("Easy goal")
    end
  end

  feature "show goals" do
    before(:each) do
    end

    scenario "users can read public posts" do
      log_in_as('potato')
      visit(user_url(User.find_by(username: 'the_best')))
      expect(page).to have_content "Public goalz"
    end

    scenario "users can read own private posts" do
      log_in_as('the_best')
      visit(user_url(User.find_by(username: 'the_best')))
      expect(page).to have_content "Private goalz"
    end

    scenario "users can not read others' private posts" do
      log_in_as('potato')
      visit(user_url(User.find_by(username: 'the_best')))
      expect(page).to_not have_content "Private goalz"
    end

    scenario "user should be able to view goal body" do
      log_in_as('the_best')
      visit(user_url(User.find_by(username: 'the_best')))
      click_link ('Public goalz')
      expect(page).to have_content "Continue to be the best publicly"
    end

  end

  feature "update posts" do
    scenario "user should have link to edit their own goal" do
      log_in_as('the_best')
      visit(user_url(User.find_by(username: 'the_best')))
      expect(page).to have_link ('Edit')
    end

    scenario "user cannot see edit link for another user's public goals" do
      log_in_as('potato')
      visit(user_url(User.find_by(username: 'the_best')))
      expect(page).to_not have_link ('Edit')
    end

    scenario "user can see the edit form for goals" do
      log_in_as("the_best")
      visit(user_url(User.find_by(username: 'the_best')))
      click_link 'edit Public goalz'
      fill_in('Body', with: 'I changed my goals lol')
      fill_in('Title', with: 'Changed Goalz')
      choose('Private')
      click_button('Update Goal')
    end

    scenario "edits to goals are saved" do
      log_in_as("the_best")
      visit(user_url(User.find_by(username: 'the_best')))
      click_link 'edit Public goalz'
      fill_in('Body', with: 'I changed my goals lol')
      fill_in('Title', with: 'Changed Goalz')
      choose('Private')
      click_button('Update Goal')
      visit(user_url(User.find_by(username: 'the_best')))
      expect(page).to have_content('Changed Goalz')
    end

    scenario "user cannot edit other users goals" do
      the_best_post = Goal.find_by(title: "Public goalz")
      log_in_as('potato')
      visit(edit_goal_url(the_best_post))
      expect(page).to_not have_button('Update Goal')
    end

  end

  feature "delete posts" do
    scenario "user can destroy own goals" do
      log_in_as('the_best')
      visit(user_url(User.find_by(username: 'the_best')))
      click_button('delete Public goalz')
      expect(page).to_not have_content "Public goalz"
    end

    scenario "user cannot see delete button on other users' goals" do
      log_in_as('potato')
      visit(user_url(User.find_by(username: 'the_best')))
      expect(page).to_not have_button('delete Public goalz')
    end
  end
end
