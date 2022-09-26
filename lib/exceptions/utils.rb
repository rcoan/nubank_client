module Exceptions
  module Utils
    class UrlNotDiscovered < StandardError
      def initialize(url = nil)
        @url = url
      end

      def message
        "Unable to find the URL requested in nubank server: #{@url}.\nPlease try again."
      end

  end
end