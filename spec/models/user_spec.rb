require 'spec_helper'

describe User do
  it 'has a valid factory' do
    FactoryGirl.build(:user).should be_valid
  end

  it 'is invalid without an email' do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it 'is invalid with a duplicate email' do
    User.destroy_all
    FactoryGirl.create(:user, email: "nufinka@example.com")
    FactoryGirl.build(:user, email: "nufinka@example.com").should_not be_valid
  end

  it 'is invalid without a username' do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end
end