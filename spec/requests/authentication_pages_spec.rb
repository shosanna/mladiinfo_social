# coding: utf-8
require 'spec_helper'

describe "Authentication Pages" do
  before { visit signin_path }
  let(:user) { FactoryGirl.create(:user) }

  it 'has a right content' do
    page.should have_content('Přihlaš se')
  end

  describe 'signing in with blank form' do
    it 'shows error messages' do
      click_button "sign in"
      page.should have_selector('div.alert.alert-error', text: 'Invalid')
    end

    it 'does not show error message when going to another page' do
      click_link "signup"
      page.should_not have_selector('div.alert.alert-error', text: 'Invalid')
    end
  end

  describe 'signing in with valid information' do
    before do
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "sign in"
    end

    it 'displays profile link' do
      page.should have_link('Můj profil', href: user_path(user))
    end

    it 'displays sign out link' do
      page.should have_link('Odhlásit se', href: signout_path)
    end

    it 'does not display log in link' do
      page.should_not have_link('Přihlásit se', href: signin_path)
    end

    it 'can be signed out' do
      click_link "Odhlásit se"
      page.should have_link('Přihlásit se', href: signin_path)
    end
  end


end

