# frozen_string_literal: true

class Url < ApplicationRecord
  validates :original_url, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  def assign_slug
    self.slug = generate_slug
  end

  def generate_slug
    10.times do
      slug = SecureRandom.alphanumeric(6)
      return slug unless Url.exists?(slug:)
    end

    raise 'Could not generate a unique short URL'
  end
end
