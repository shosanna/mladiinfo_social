# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}

    password "mystring"
    password_confirmation { |user| user.password }
  end

  factory :invalid_user, class: "User" do
    username " "
    email " "
    password " "
    password_confirmation " "
  end
end
