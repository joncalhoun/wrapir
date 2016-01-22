class Wrapir
  class EndpointMethodBuilder

    def self.declare(klass, name, verb, path, arguments)
      eval code(klass, name, verb, path, arguments)
    end

  private

    def self.code(klass, name, verb, path, arguments)
      code = <<CODE
      #{klass}.send(:define_method, #{name.inspect}) do |#{arguments.map{ |a| "#{a}, " }.join}params = {}, headers = {}|
        path_values = build_required_hash(#{name.inspect}#{arguments.map{ |a| ", #{a}" }.join})
        method = ApiMethod.new(#{verb.inspect}, '#{path}', {
          path_values: path_values,
          params: params,
          headers: headers
        })
        @client.execute(method)
      end
CODE
    end
  end
end
