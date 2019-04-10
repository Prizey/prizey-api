# frozen_string_literal: true

class GameSetting < ApplicationRecord
  validates :easy_carousel_speed, :medium_carousel_speed, :hard_carousel_speed,
    presence: true

  def as_json(_options = {})
    {
      id: id,
      easy_carousel_speed: easy_carousel_speed,
      medium_carousel_speed: medium_carousel_speed,
      hard_carousel_speed: hard_carousel_speed
    }
  end
end
