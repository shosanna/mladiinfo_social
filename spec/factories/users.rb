# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "MyString"
    email "MyString@example.com"
    password "mystring"
    password_confirmation "mystring"

  end
end