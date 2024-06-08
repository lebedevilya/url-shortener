# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    let(:original_url) { 'https://codesubmit.io/library/react' }
    let(:slug) { 'GeAi9K' }
    let(:url) { Url.new(original_url:, slug:) }

    it 'is valid with valid attributes' do
      expect(url).to be_valid
    end

    context 'without an original URL' do
      let(:original_url) { nil }
      it { expect(url).not_to be_valid }
    end

    context 'without a slug' do
      let(:slug) { nil }
      it { expect(url).not_to be_valid }
    end

    it 'is not valid with a duplicate original URL' do
      Url.create!(original_url:, slug: 'test')
      expect(url).not_to be_valid
    end

    it 'is not valid with a duplicate shortened URL' do
      Url.create!(original_url: 'https://codesubmit.io/library/rails', slug:)
      expect(url).not_to be_valid
    end
  end
end
