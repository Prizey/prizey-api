# frozen_string_literal: true

class Setting < ApplicationRecord
  validates :easy_tickets, :medium_tickets, :hard_tickets, :easy_carousel_speed,
    :medium_carousel_speed, :hard_carousel_speed, presence: true

  def as_json(_options = {})
    {
      id: id,
      easy_tickets: easy_tickets,
      medium_tickets: medium_tickets,
      hard_tickets: hard_tickets,
      easy_carousel_speed: easy_carousel_speed,
      medium_carousel_speed: medium_carousel_speed,
      hard_carousel_speed: hard_carousel_speed
    }
  end
end
