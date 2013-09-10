# coding: utf-8
require 'spec_helper'

describe "Authentication Pages" do
  before { visit signin_path }
  let(:user) { FactoryGirl.create(:user) }

  it 'has a sign in title' do
    page.should have_content('Přihlaš se')
  end

  it 'is invalid when sign in with blank form' do
    click_button "sign in"
    page.should have_selector('div.alert.alert-error', text: 'Invalid')
  end

  it 'is valid when sign in with correct form' do
    fill_in "Email",    with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Sign in"
    page.should have_link('Profile', href: user_path(user))
    page.should have_link('Sign out', href: signout_path)
    page.should_not have_link('Sign in', href: signin_path)
  end

end

