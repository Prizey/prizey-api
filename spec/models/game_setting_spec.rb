# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameSetting, type: :model do
  it { is_expected.to validate_presence_of :price_multiplier }
  it { is_expected.to validate_presence_of :easy_carousel_speed }
  it { is_expected.to validate_presence_of :medium_carousel_speed }
  it { is_expected.to validate_presence_of :hard_carousel_speed }
  it { is_expected.to validate_presence_of :easy_ticket_amount }
  it { is_expected.to validate_presence_of :medium_ticket_amount }
  it { is_expected.to validate_presence_of :hard_ticket_amount }
  it { is_expected.to validate_presence_of :homepage_cta }

  describe '#as_json' do
    let(:game_setting) { create(:game_setting) }

    let(:json) do
      {
        id: game_setting.id,
        price_multiplier: 0.5,
        easy_carousel_speed: 1,
        medium_carousel_speed: 2,
        hard_carousel_speed: 3,
        easy_ticket_amount: 1,
        medium_ticket_amount: 2,
        hard_ticket_amount: 3,
        fairness_text: 'fairness text',
        terms_of_service: 'terms of service',
        privacy_policy: 'privacy policy',
        homepage_cta: 'Play now for $3!'
      }
    end

    it { expect(game_setting.as_json).to eq(json) }
  end
end
