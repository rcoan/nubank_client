require 'openssl'

module Services
  module Auth
    module GenerateCertificate
      class SaveCertificate
        def self.call(args)
          self.new.save_certificate(**args)
        end

        def save_certificate(certificate:)
          persist_certificates(certificate: certificate)
          print_warnings
          p certificate
          p certificate.to_s
        end

        private

        def persist_certificates(certificate:)
          File.new(Dir.pwd) do
            certificate
          end
        end

        def print_warnings
          p "Certificates generated successfully. (cert.pem)"
          p "ATTENTION, keep these certificates safe, as they give full access to your account"
        end
      end
    end
  end
end