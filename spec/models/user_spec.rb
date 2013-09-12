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

  it 'has a remember_token attribute' do
    subject.should respond_to(:remember_token)
  end

  it 'has a default remember token when created' do
    user = FactoryGirl.create(:user)
    user.remember_token.should_not be_blank
  end

  describe "password" do
    it 'is invalid when nil' do
      FactoryGirl.build(:user, password: nil, password_confirmation: nil).should_not be_valid
    end

    it 'is invalid when it does not match the confirmation' do
      FactoryGirl.build(:user, password: "mystring", password_confirmation: "mystringgg").should_not be_valid
    end

    it 'is valid when it matches the confirmation' do
      FactoryGirl.build(:user, password: "mystring", password_confirmation: "mystring").should be_valid
    end

    it 'is invalid when too short' do
      FactoryGirl.build(:user, password: "foo", password_confirmation: "foo")
    end
  end

  describe "authentication" do
    before(:each) { User.destroy_all }
    let(:user) { FactoryGirl.create(:user) }
    let(:found_user) { User.find_by(email: user.email) }
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it 'is valid with correct email' do
      user.should eq found_user.authenticate(user.password)
    end

    it 'is invalid with wrong email' do
      user.should_not eq user_for_invalid_password
    end
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