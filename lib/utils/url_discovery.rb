# frozen_string_literal: true

module Utils
  class UrlDiscovery
    DISCOVERY_URL = 'https://prod-s0-webapp-proxy.nubank.com.br/api/discovery'

    def initialize
      @url_map = HttpClient.get(url: DISCOVERY_URL)
    end

    def url_for(resource_name:)
      @url_map[resource_name]
    end
  end
end
