# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :set_url, only: [:decode]

  def encode
    @url = Url.find_or_create_by(original_url: params[:url]) do |url|
      url.assign_slug
    end

    render json: { url: @url.original_url, short_url: short_url(@url.slug) }, status: :ok
  end

  def decode
    if @url
      render json: { url: @url.original_url, short_url: short_url(@url.slug) }, status: :ok
    else
      render json: { error: "Short URL not found" }, status: :not_found
    end
  end

  private

  def set_url
    uri = URI.parse(params[:short_url])
    valid_host = Rails.application.config.action_mailer.default_url_options[:host]

    if uri.host != valid_host
      render json: { error: "Invalid host" }, status: :unprocessable_entity
      return
    end

    short_code = uri.path.split('/').last
    @url = Url.find_by(slug: short_code)
  rescue URI::InvalidURIError
    render json: { error: "Invalid URL" }, status: :unprocessable_entity
  end

  def short_url(short_code)
    "#{request.base_url}/#{short_code}"
  end
end
