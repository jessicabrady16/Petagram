FactoryBot.define do
  factory :user do
    email { "dummyEmail@gmail.com" }
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end
end
