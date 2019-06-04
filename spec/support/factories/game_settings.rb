# frozen_string_literal: true

FactoryBot.define do
  factory :game_setting do
    price_multiplier 0.5
    easy_carousel_speed 1
    medium_carousel_speed 2
    hard_carousel_speed 3
    easy_ticket_amount 1
    medium_ticket_amount 2
    hard_ticket_amount 3
    game_blocked false
    fairness_text 'fairness text'
    terms_of_service 'terms of service'
    privacy_policy 'privacy policy'
    starting_balance 0
  end
end
