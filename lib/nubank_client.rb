require './config/loader'

class NubankClient
  def self.generate_certificate
    Interactors::Auth::GenerateCertificate.call
  end
end