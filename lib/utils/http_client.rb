# frozen_string_literal: true

require 'net/http'
require 'JSON'

module Utils
  class HttpClient
    def self.post(url:, payload:, content_type: 'application/json')
      uri = URI(url)
      response = Net::HTTP.post(uri, payload.to_json, 'Content-Type' => content_type)
      JSON.parse(response.body)
    end

    def self.post_with_raw_response(url:, payload:, content_type: 'application/json')
      uri = URI(url)
      response = Net::HTTP.post(uri, payload.to_json, 'Content-Type' => content_type)
      {
        body: JSON.parse(response.body),
        raw: response
      }
    end

    def self.get(url:)
      uri = URI(url)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end
end
