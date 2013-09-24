# coding: utf-8
require 'spec_helper'
require 'utilities'

describe "User pages" do

  subject { page }

  describe "profile" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it 'has the right content' do
      should have_content(user.username)
    end
  end

  describe "signup" do
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

  describe "edit" do
    let(:user) {FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    it "has the right content" do
      should have_content('Upravit profil')
    end

    it "has a link  to change a gravatar" do
      should have_link('Změnit gravatar', href: 'http://gravatar.com/emails')
    end

    it "displays an error when submiting with invalid information" do
      fill_in "Username", with: " "
      click_button "edit"
      should have_content('error')
    end

    it 'updates user username' do
      fill_in "Username",     with: "New Name"
      fill_in "Email",        with: user.email
      fill_in "Password",     with: user.password
      fill_in "Confirmation", with: user.password
      click_button "edit"
      should have_content("New Name")
    end
  end
end