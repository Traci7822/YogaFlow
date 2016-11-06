require 'rails_helper'

RSpec.feature "LogInPage", type: :feature do
  describe "log_in" do
    it "allows a user to log in" do
      visit log_in_path
      user = FactoryGirl.create(:user)
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
      expect(page.has_content?("TestUser"))
    end
  end
end
