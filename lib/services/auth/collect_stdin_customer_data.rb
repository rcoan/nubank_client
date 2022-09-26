# frozen_string_literal: true

require 'io/console'
require 'openssl'

module Services
  module Auth
    module GenerateCertificate
      class CollectStdinCustomerData
        def self.call(args)
          new.collect_data(**args)
        end

        def collect_data(url_map:)
          pem_cert_public = OpenSSL::PKey::RSA.generate(2048)
          pem_cert_crypto = OpenSSL::PKey::RSA.generate(2048)
          url = url_map.url_for(resource_name: 'auth_gen_certificates')

          raise Exceptions::Utils::UrlNotDiscovered, 'auth_gen_certificates' if url.nil?

          user_data = {
            login: login,
            password: password,
            device_id: device_id,
            certificate_key: pem_cert_public,
            model: "NubankClient Ruby #{device_id}",
            certificate_key_crypto: pem_cert_crypto
          }

          encrypted_code = encrypted_code(**user_data.merge(url: url))
          user_data.merge(encrypted_code: encrypted_code, tfa_code: tfa_code)
        end

        private

        def login
          p 'Insert your Nubank login (CPF):'
          gets.chomp.strip
        end

        def password
          p 'Insert your Nubank password:'
          $stdin.noecho(&:gets).chomp.strip
        end

        def device_id
          device_id ||= SecureRandom.hex(12)
        end

        def authentication_code
          p 'Insert your Nubank password:'
          gets.chomp.strip
        end

        def encrypted_code(login:, password:, device_id:, model:, certificate_key:,
                           certificate_key_crypto:, url:)
          payload = {
            login: login,
            password: password,
            model: model,
            public_key: certificate_key.public_key.to_s,
            public_key_crypto: certificate_key_crypto.public_key.to_s,
            device_id: device_id
          }

          response = Utils::HttpClient.post_with_raw_response(url: url, payload: payload)
          header = response[:raw]['WWW-Authenticate']

          auth_header_itens = header.split.to_h do |item|
            key_value = item.split('=')
            [key_value[0], key_value[1..].join.gsub(/\"|,/, '')]
          end

          auth_header_itens['encrypted-code']
        rescue
          raise Exceptions::Auth::BaseAuthenticationFailed
        end

        def tfa_code
          p 'Nubank sent your authentication code to your registered email, type it here:'
          gets.chomp.strip
        end
      end
    end
  end
end
