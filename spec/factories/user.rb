FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "johndoe#{n}@example.com" }
    password 'nufinka33'
    password_confirmation 'nufinka33'
    username "Zuzanka"
  end
end