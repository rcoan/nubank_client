# frozen_string_literal: true

require 'securerandom'
module Interactors
  module Auth
    class GenerateCertificate
      def self.call
        url_map = Utils::UrlDiscovery.new
        user_data = Services::Auth::GenerateCertificate::CollectStdinCustomerData.call(url_map: url_map)
        certificates = Services::Auth::GenerateCertificate::GenerateCertificate.call(**user_data.merge(url_map: url_map))
        Services::Auth::GenerateCertificate::SaveCertificate.call(**certificates)
      end
    end
  end
end
