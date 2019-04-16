# frozen_string_literal: true

FactoryBot.define do
  factory :ticket_transaction do
    user
    amount 10
  end
end
