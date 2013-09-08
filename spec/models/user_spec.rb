require 'spec_helper'

describe User do
  it 'has a valid factory' do
    FactoryGirl.build(:user).should be_valid
  end

  it 'is invalid without a username' do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it 'is invalid with too long username' do
    FactoryGirl.build(:user, username: "itisjusttoolongusername")
  end

  it 'is invalid without a password' do
    FactoryGirl.build(:user, password: nil, password_confirmation: nil).should_not be_valid
  end

  it 'is invalid when passwords do not match' do
    FactoryGirl.build(:user, password: "mystring", password_confirmation: "mystringgg").should_not be_valid
  end

  it 'is valid when passwords match' do
    FactoryGirl.build(:user, password: "mystring", password_confirmation: "mystring").should be_valid
  end

  describe "email" do
    it 'is invalid when blank' do
      FactoryGirl.build(:user, email: nil).should_not be_valid
    end

    it 'is invalid when duplicated' do
      User.destroy_all
      FactoryGirl.create(:user, email: "nufinka@example.com")
      FactoryGirl.build(:user, email: "nufinka@example.com").should_not be_valid
    end

    it 'is invalid in a wrong format' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        FactoryGirl.build(:user, email: invalid_address).should_not be_valid
      end
    end

    it 'is valid in a correct format' do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        FactoryGirl.build(:user, email: valid_address).should be_valid
      end
    end
  end
end