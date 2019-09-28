# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'dummyEmail@gmail.com' }
    password { 'secretPassword' }
    password_confirmation { 'secretPassword' }
  end

  factory :gram do
    message { 'hello' }
    association :user
  end
end
