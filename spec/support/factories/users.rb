# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user_#{n}@example.com"
    end
    fullname 'foobar'
    address 'foobar'
    city 'foobar'
    state_province_region 'foobar'
    zipcode 'foobar'
    clothing_size 'foobar'
    shoe_size 'foobar'
    password '123123123'
  end
end
