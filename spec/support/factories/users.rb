# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user_#{n}@example.com"
    end
    fullname { 'foo bar' }
    address { 'foo bar' }
    city { 'foobar' }
    state_province_region { 'foobar' }
    zipcode { 'foobar' }
    clothing_size { 'M' }
    shoe_size { '40' }
    password { '123123123' }
    stripe_customer_id { 'us_123' }
  end
end
