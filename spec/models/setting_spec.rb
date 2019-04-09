# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Setting, type: :model do
  it { is_expected.to validate_presence_of :easy_tickets }
  it { is_expected.to validate_presence_of :medium_tickets }
  it { is_expected.to validate_presence_of :hard_tickets }
  it { is_expected.to validate_presence_of :easy_carousel_speed }
  it { is_expected.to validate_presence_of :medium_carousel_speed }
  it { is_expected.to validate_presence_of :hard_carousel_speed }

  describe '#as_json' do
    let(:setting) { create(:setting) }

    let(:json) do
      {
        id: setting.id,
        easy_tickets: 1,
        medium_tickets: 2,
        hard_tickets: 3,
        easy_carousel_speed: 1,
        medium_carousel_speed: 2,
        hard_carousel_speed: 3
      }
    end

    it { expect(setting.as_json).to eq(json) }
  end
end
