# frozen_string_literal: true

require './config/loader'

module NubankClient
  class Cli
    def self.generate_certificate
      Interactors::Auth::GenerateCertificate.call
    rescue StandardError => e
      e.message
    end
  end
end
