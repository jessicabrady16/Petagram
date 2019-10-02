# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    message { 'comments are cool' }
  end

  factory :user do
    sequence(:email) { |n| "dummyEmail#{n}@gmail.com" }
    password { 'secretPassword' }
    password_confirmation { 'secretPassword' }
  end

  factory :gram do
    message { 'hello' }
    picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png').to_s, 'image/png') }
    association :user
  end
end
