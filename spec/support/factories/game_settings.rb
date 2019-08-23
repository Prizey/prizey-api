# frozen_string_literal: true

FactoryBot.define do
  factory :game_setting do
    price_multiplier 0.5
    easy_carousel_speed 1
    medium_carousel_speed 2
    hard_carousel_speed 3
    game_blocked false
    starting_balance 0
    ad_diamonds_reward 3
    vast_tag 'abc123'
  end
end
