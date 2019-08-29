# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameSetting, type: :model do
  it { is_expected.to validate_presence_of :price_multiplier }
  it { is_expected.to validate_presence_of :easy_carousel_speed }
  it { is_expected.to validate_presence_of :medium_carousel_speed }
  it { is_expected.to validate_presence_of :hard_carousel_speed }
  it { is_expected.to validate_presence_of :ad_diamonds_reward }

  describe '#as_json' do
    let(:game_setting) { create(:game_setting) }

    let(:json) do
      {
        id: game_setting.id,
        price_multiplier: 0.5,
        easy_carousel_speed: 1,
        medium_carousel_speed: 2,
        hard_carousel_speed: 3,
        ad_diamonds_reward: 3,
        vast_tag: 'abc123',
        video_ads_for_reward: 1,
        sell_it_back_amount: 3,
        home_carousel_speed: 1
      }
    end

    it { expect(game_setting.as_json).to eq(json) }
  end
end
