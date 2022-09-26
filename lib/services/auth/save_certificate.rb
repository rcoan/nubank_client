# frozen_string_literal: true

require 'openssl'

module Services
  module Auth
    module GenerateCertificate
      class SaveCertificate
        def self.call(args)
          new.save_certificate(**args)
        end

        def save_certificate(certificate:)
          persist_certificates(certificate: certificate)
          print_warnings
        end

        private

        def persist_certificates(certificate:)
          File::open(File.join([Dir.pwd, "nubank_personal_cert.der"]), 'w+b') do |file|
            file << certificate.to_der
          end
        end

        def print_warnings
          p 'Certificates generated successfully. (nubank_personal_cert.der)'
          p 'ATTENTION, keep these certificates safe, as they give full access to your account'
        end
      end
    end
  end
end
