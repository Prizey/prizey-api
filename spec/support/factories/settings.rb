# frozen_string_literal: true

FactoryBot.define do
  # rubocop
  factory :setting do
    easy_tickets 1
    medium_tickets 2
    hard_tickets 3
    easy_carousel_speed 1
    medium_carousel_speed 2
    hard_carousel_speed 3
  end
end
