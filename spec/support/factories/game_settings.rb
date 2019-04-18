# frozen_string_literal: true

FactoryBot.define do
  factory :game_setting do
    price_multiplier 1
    easy_carousel_speed 1
    medium_carousel_speed 2
    hard_carousel_speed 3
    easy_ticket_amount 1
    medium_ticket_amount 2
    hard_ticket_amount 3
  end
end
