require 'wrapir'

class Paid
  class DefaultHeaders < Wrapir::Middleware
    def initialize(hash)
    end

    def apply(api_method)
      api_method.headers.apply({
        ruby_version: RUBY_VERSION,
        api_version: "v0"
      })
    end
  end
end
