# frozen_string_literal: true

FactoryBot.define do
  factory :purchase_option do
    trait :easy do
      name 'easy'
      price 10.0
      ticket_amount 10
    end

    trait :medium do
      name 'medium'
      price 25.0
      ticket_amount 25
    end

    trait :hard do
      name 'hard'
      price 50.0
      ticket_amount 50
    end
  end
end
