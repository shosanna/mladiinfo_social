require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.username) }
  end

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "submit" }

    it { should have_content('Zaregistruj') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      it "should create a user" do
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
    end

    describe "after submission" do
      before { click_button submit }
      it { should have_content('error') }
    end
  end
end