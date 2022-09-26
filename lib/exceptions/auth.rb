module Exceptions
  module Auth
    class BaseAuthenticationFailed < StandardError
      def message
        "Authentication using Login and password failed. Check if info is correct."
      end
    end

    class CertificatExchangeFailed < StandardError
      def message
        "Failed to sent certificate to nubank validation. Try again later."
      end
    end
  end
end