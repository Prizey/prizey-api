# frozen_string_literal: true

class GameSetting < ApplicationRecord
  validates :price_multiplier, :easy_carousel_speed, :medium_carousel_speed,
    :hard_carousel_speed, :ad_diamonds_reward, presence: true

  # rubocop:disable Metrics/MethodLength
  def as_json(_options = {})
    {
      id: id,
      price_multiplier: price_multiplier,
      easy_carousel_speed: easy_carousel_speed,
      medium_carousel_speed: medium_carousel_speed,
      hard_carousel_speed: hard_carousel_speed,
      ad_diamonds_reward: ad_diamonds_reward,
      vast_tag: vast_tag,
      video_ads_for_reward: video_ads_for_reward,
      sell_it_back_amount: sell_it_back_amount,
      home_carousel_speed: home_carousel_speed
    }
  end
  # rubocop:enable Metrics/MethodLength
end
