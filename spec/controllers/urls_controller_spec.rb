# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe 'POST #encode' do
    it 'encodes a URL' do
      post :encode, params: { url: 'https://codesubmit.io/library/react' }, format: :json
      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response['url']).to eq('https://codesubmit.io/library/react')
      expect(json_response['short_url']).to match(%r{http://test.host/\w{6}})
    end
  end

  describe 'POST #decode' do
    let!(:url) { Url.create(original_url: 'https://codesubmit.io/library/react', slug: 'GeAi9K') }

    it 'decodes a short URL' do
      post :decode, params: { short_url: "http://test.host/#{url.slug}" }, format: :json
      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response['url']).to eq(url.original_url)
      expect(json_response['short_url']).to eq("http://test.host/#{url.slug}")
    end

    it 'returns not found for invalid short URL' do
      post :decode, params: { short_url: 'http://test.host/invalid' }, format: :json
      expect(response).to have_http_status(:not_found)

      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Short URL not found')
    end

    it 'returns unprocessable entity for invalid host' do
      post :decode, params: { short_url: "http://invalid.host/#{url.slug}" }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)

      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Invalid host')
    end

    it 'returns unprocessable entity for invalid URL format' do
      post :decode, params: { short_url: '2:test*invalid_url' }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)

      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Invalid URL')
    end
  end
end
