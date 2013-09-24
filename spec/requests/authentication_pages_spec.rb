# coding: utf-8
require 'spec_helper'
require 'utilities'

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
    before { sign_in user }

    it 'displays profile link' do
      page.should have_link('Můj profil', href: user_path(user))
    end

    it 'displays sign out link' do
      page.should have_link('Odhlásit se', href: signout_path)
    end

    it 'does not display log in link' do
      page.should_not have_link('Přihlásit se', href: signin_path)
    end

    it 'displays edit link' do
      page.should have_link('Nastavení', href: edit_user_path(user))
    end

    it 'can be signed out' do
      click_link "Odhlásit se"
      page.should have_link('Přihlásit se', href: signin_path)
    end
  end

  describe 'for non-signed in users' do
    let(:user) { FactoryGirl.create(:user) }
    it ' displays login page when trying to edit someone profile' do
      visit edit_user_path(user)
      page.should have_content('Přihlaš se')
    end

    it 'redirects to signin page when submitting update action' do
      patch user_path(user)
      expect{response}.to redirect_to(signin_path)
    end
  end


  # TODO - Rewrite these specs bellow in my own words - they are copied from the book!!
  describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect{response.body}.not_to have_content('Upravit') }
        specify { expect{response}.to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect{response}.to redirect_to(root_url) }
      end
    end


end

