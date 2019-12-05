# frozen_string_literal: true

require 'rails_helper'

describe 'POST /freegame_ips', type: :request do
  context 'with correct params' do
    before do
      post '/freegame_ips'
    end

    it { expect(response).to have_http_status(:created) }
  end

  context 'with incorrect params' do
    before { post '/freegame_ips', params: { foo: 'bar' }.to_json }

    it { expect(response).to have_http_status(:bad_request) }
  end

  context 'when the page is invalid' do
    let(:params) { { page: 'page4' }.to_json }
    let(:create_pages) do
      AdminText.create!(
        field: 'valid_free_game_pages',
        text: 'page1, page2, page3'
      )
    end

    before do
      create_pages
      post '/freegame_ips', params: params
    end

    it { expect(response).to have_http_status(:created) }
    it {
      expect(JSON(response.body)).to eq(
        'ip_blocked' => false,
        'page_valid' => false,
        'id' => 1
      )
    }
  end

  context 'when the page is valid' do
    let(:params) { { page: 'page2' }.to_json }
    let(:create_pages) do
      AdminText.create!(
        field: 'valid_free_game_pages',
        text: 'page1, page2, page3'
      )
    end

    before do
      create_pages
      post '/freegame_ips', params: params
    end

    it { expect(response).to have_http_status(:created) }
    it {
      expect(JSON(response.body)).to eq(
        'ip_blocked' => false,
        'page_valid' => true,
        'id' => 1
      )
    }
  end

  context 'when the page is blank' do
    let(:create_pages) do
      AdminText.create!(
        field: 'valid_free_game_pages',
        text: 'page1, page2, page3'
      )
    end

    before do
      create_pages
      post '/freegame_ips'
    end

    it { expect(response).to have_http_status(:created) }
    it {
      expect(JSON(response.body)).to eq(
        'ip_blocked' => false,
        'page_valid' => true,
        'id' => 1
      )
    }
  end
end
