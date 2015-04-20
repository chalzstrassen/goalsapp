require 'spec_helper'
require 'rails_helper'

feature "Comments" do
  before(:each) do
    setup
  end

  feature "user can comment on goals" do
    scenario "user can comment on other users' public goals" do
      log_in_as('potato')
      visit(root_url)
      click_link('the_best')
      click_link('Public goalz')
      fill_in "Comment", with: "You're not the best."
      click_button("Submit Comment")
      expect(find(".comment")).to have_content "You're not the best."
    end
  end

  feature "user can comment on users" do

  end
end
