require 'wrapir'

class Paid
  class CustomAuth < Wrapir::HTTPBasicAuth
    def initialize(hash)
      @username = hash[:api_key]
      @password = ""
    end
  end
end
