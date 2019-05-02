# frozen_string_literal: true

FactoryBot.define do
  factory :purchase_option do
    trait :pack_1 do
      name 'pack_1'
      price 10.0
      ticket_amount 10
    end

    trait :pack_2 do
      name 'pack_2'
      price 25.0
      ticket_amount 25
    end

    trait :pack_3 do
      name 'pack_3'
      price 50.0
      ticket_amount 50
    end
  end
end
