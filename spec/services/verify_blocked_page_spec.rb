# frozen_string_literal: true

require 'rails_helper'

describe VerifyBlockedPage, type: :service do
  context 'when ip was not created more than 10 minutes' do
    before do
      Blacklist.create!(ip_address: '127.0.0.1', created_at: 10.seconds.ago)
    end

    it do
      expect(described_class.execute(ip_address: '127.0.0.1'))
        .to eq(success: true, payload: true)
    end
  end

  context 'when ip was created more than 10 minutes' do
    before do
      Blacklist.create!(ip_address: '127.0.0.1', created_at: 11.minutes.ago)
    end

    it do
      expect(described_class.execute(ip_address: '127.0.0.1'))
        .to eq(success: true, payload: false)
    end
  end

  context 'when ip was not created more than 10 minutes and page is valid' do
    let(:create_pages) do
      AdminText.create!(
        field: 'valid_free_game_pages',
        text: 'page1, page2, page3'
      )
    end

    before do
      create_pages
      Blacklist.create!(
        ip_address: '127.0.0.1', page: 'page1', created_at: 10.seconds.ago
      )
    end

    it do
      expect(described_class.execute(ip_address: '127.0.0.1', page: 'page1'))
        .to eq(success: true, payload: true)
    end

    it 'with page different from the one created' do
      expect(described_class.execute(ip_address: '127.0.0.1', page: 'page3'))
        .to eq(success: true, payload: false)
    end
  end

  context 'when ip was not created more than 10 minutes and page is invalid' do
    let(:create_pages) do
      AdminText.create!(
        field: 'valid_free_game_pages',
        text: 'page1, page2, page3'
      )
    end

    before do
      create_pages
      Blacklist.create!(
        ip_address: '127.0.0.1', page: 'page1', created_at: 10.seconds.ago
      )
    end

    it do
      expect(described_class.execute(ip_address: '127.0.0.1', page: 'page10'))
        .to eq(success: true, payload: true)
    end
  end
end
