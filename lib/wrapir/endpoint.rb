class Wrapir
  class Endpoint
    attr_accessor :client

    def initialize(client)
      @client = client
    end

    def build_required_hash(method_name, *values)
      ret = {}
      method = self.class.instance_method(method_name)
      method.parameters[0..-3].map(&:last).each_with_index do |arg, i|
        ret[arg] = values[i]
      end
      ret
    end
  end
end
