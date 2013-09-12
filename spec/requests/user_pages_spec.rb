require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it 'has the right content' do
      should have_content(user.username)
    end
  end

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "submit" }

    it 'has the right content' do
      should have_content('Zaregistruj')
    end

    it "does not create a user with blank form" do
      expect { click_button submit }.not_to change(User, :count)
    end

    it "creates a user with valid information" do
      fill_in "Username",     with: "Example User"
      fill_in "Email",        with: "user@example.com"
      fill_in "Password",     with: "foobar"
      fill_in "Confirmation", with: "foobar"
      expect { click_button submit }.to change(User, :count).by(1)
    end

    it "shows flash after registration" do
      fill_in "Username",     with: "Example User"
      fill_in "Email",        with: "user@example.com"
      fill_in "Password",     with: "foobar"
      fill_in "Confirmation", with: "foobar"
      click_button submit
      page.should have_selector('div.alert.alert-success')
    end

    it "has error message when send without correct information" do
      click_button submit
      page.should have_content('error')
    end
  end
end