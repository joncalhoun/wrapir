require 'wrapir'

class Paid
  class JsonParser < Wrapir::Middleware
    def initialize(hash)
    end

    # What all happens?
    # 1. We create the api method which defines:
    #   a. URL
    #   b. Method (get, post, etc)
    #   c. Params
    #   d. Headers
    #   e. URL Arguments (id, etc)

    def before(api_method)
      api_method.headers.apply({
        ruby_version: RUBY_VERSION,
        api_version: "v0"
      })
    end

    def after(api_method)

    end

    def on_error(error)
      # handle errors here of some specific type, eg a RestClient::RequestTimeout error. If you don't want to handle an error you need to raise it again.
    end

  end
end
