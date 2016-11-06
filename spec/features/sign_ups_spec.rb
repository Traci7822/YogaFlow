require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  describe "sign_up" do
    it "allows a user to sign up for an account" do
      user = FactoryGirl.build(:user)
      visit sign_up_path
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
      click_button "Create User"
      expect(page).to have_content("TestUser")
    end
  end
end
