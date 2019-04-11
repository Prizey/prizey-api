# frozen_string_literal: true

FactoryBot.define do
  factory :game_setting do
    price_multiplier 1
    easy_carousel_speed 1
    medium_carousel_speed 2
    hard_carousel_speed 3
  end
end
