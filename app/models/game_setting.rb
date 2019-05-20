# frozen_string_literal: true

class GameSetting < ApplicationRecord
  validates :price_multiplier, :easy_carousel_speed, :medium_carousel_speed,
    :hard_carousel_speed, :easy_ticket_amount, :medium_ticket_amount,
    :hard_ticket_amount, presence: true

  # rubocop:disable Metrics/MethodLength
  def as_json(_options = {})
    {
      id: id,
      price_multiplier: price_multiplier,
      easy_carousel_speed: easy_carousel_speed,
      medium_carousel_speed: medium_carousel_speed,
      hard_carousel_speed: hard_carousel_speed,
      easy_ticket_amount: easy_ticket_amount,
      medium_ticket_amount: medium_ticket_amount,
      hard_ticket_amount: hard_ticket_amount,
      fairness_text: fairness_text,
      terms_of_service: terms_of_service
    }
  end
  # rubocop:enable Metrics/MethodLength
end
