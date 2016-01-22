class Wrapir
  class ApiMethod
    attr_accessor :verb
    attr_accessor :path
    attr_accessor :params
    attr_accessor :headers

    attr_accessor :response_body
    attr_accessor :response_code
    attr_accessor :error

    def initialize(verb, path, opts = {})
      @api_base = api_base || Rainforest.api_base

      @verb = verb.to_sym
      @path = PathBuilder.build(path, opts[:path_values])
      # @params = ParamsBuilder.build(params)
      # @headers = HeadersBuilder.build(headers)
    end

    def execute
      # begin
      #   response = Requester.request(verb, url, params, headers)
      #   @response_body = response.body
      #   @response_code = response.code
      # rescue StandardError => e
      #   @response_body = e.http_body if e.respond_to?(:http_body)
      #   @response_code = e.http_code if e.respond_to?(:http_code)
      #   @error = compose_error(e)
      #   raise @error
      # end


      # response_json
    end

    def url
      # "#{api_base}#{@path}"
    end

    # def response_json
    #   return @json if @json
    #   begin
    #     @json = Util.symbolize_keys(JSON.parse(@response_body))
    #   rescue JSON::ParserError
    #     @error = ApiError.new("Unable to parse the server response as JSON.", self)
    #     raise @error
    #   end
    #   @json
    # end

    # def compose_error(error)
    #   msg = "An error occured while making the API call."

    #   case error
    #   when RestClient::ExceptionWithResponse
    #     return error_with_response(error)

    #   when RestClient::RequestTimeout
    #     msg = "The request timed out while making the API call."

    #   when RestClient::ServerBrokeConnection
    #     msg = "The connection to the server broke before the request completed."

    #   when SocketError
    #     msg = "An unexpected error occured while trying to connect to " \
    #       "the API. You may be seeing this message because your DNS is " \
    #       "not working. To check, try running 'host #{Rainforest.api_base}' "\
    #       "from the command line."

    #   else
    #     msg = "An unexpected error occured. If this problem persists let us " \
    #       "know at #{Rainforest.support_email}."
    #   end

    #   return ApiConnectionError.new(msg, self)
    # end

    # # Handle a few common cases.
    # def error_with_response(error)
    #   case @response_code
    #   when 400, 404
    #     return ApiError.new(@response_body || "Invalid request. Please check the URL and parameters.", self)
    #   when 401
    #     return AuthenticationError.new(@response_body || "Authentication failed.", self)
    #   else
    #     return ApiError.new(@response_body || "An error occured while making the API call.", self)
    #   end
    # end

  end
end
