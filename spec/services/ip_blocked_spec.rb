# frozen_string_literal: true

require 'rails_helper'

describe IpBlocked, type: :service do
  context 'when ip was not created more than 10 minutes' do
    before do
      IpsBlocked.create!(user_ip: '127.0.0.1')
    end

    it do
      expect(described_class.execute(ip: '127.0.0.1'))
        .to eq(success: true, payload: true)
    end
  end

  context 'when ip was created more than 10 minutes' do
    before do
      IpsBlocked.create!(user_ip: '127.0.0.1', created_at: 11.minutes.ago)
    end

    it do
      expect(described_class.execute(ip: '127.0.0.1'))
        .to eq(success: true, payload: false)
    end
  end
end
