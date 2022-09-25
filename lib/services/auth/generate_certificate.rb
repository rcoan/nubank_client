# frozen_string_literal: true

require 'openssl'

module Services
  module Auth
    module GenerateCertificate
      class GenerateCertificate
        def self.call(args)
          new.generate_certificate(**args)
        end

        def generate_certificate(login:, password:, device_id:, model:, certificate_key:,
                                 certificate_key_crypto:, tfa_code:, encrypted_code:, url_map:)
          payload = {
            login: login,
            password: password,
            device_id: device_id,
            public_key: certificate_key.public_key.to_s,
            public_key_crypto: certificate_key_crypto.public_key.to_s,
            model: model,
            code: tfa_code,
            encrypted_code: encrypted_code
          }

          url = url_map.url_for(resource_name: 'auth_gen_certificates')

          response = Utils::HttpClient.post(url: url, payload: payload)

          p response

          certificate = parse_certificate(response['certificate'])

          {
            certificate: generate_p12(certificate_key, certificate)
          }
        end

        private

        def parse_certificate(certificate)
          OpenSSL::X509::Certificate.new(certificate)
        end

        def generate_p12(key, certificate)
          OpenSSL::PKCS12.create(
            'pass',
            "Nubank auth certificate for #{login} at #{device_id}",
            key,
            certificate
          )
        end
      end
    end
  end
end
