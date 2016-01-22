
class Wrapir
  class EndpointBuilder
    def self.default_options(name)
      {
        path: "/#{name}"
      }
    end

    def self.declare(base_class, name, opts = {}, &block)
      @opts = default_options(name).merge(opts)
      endpoint_name = build_name(base_class, name)
      eval code(endpoint_name)
      klass = Object.const_get(endpoint_name)

      EndpointMethodBuilder.declare(klass, :retrieve, :get, @opts[:path], [:id])
      # instance_eval &block
    end

  private

    def self.build_name(base_class, name)
      name = "#{name}_endpoint".split("_").map(&:capitalize).join
      "#{base_class}::#{name}"
    end

    def self.code(name)
      code = <<CODE
        class #{name} < Wrapir::Endpoint
        end
CODE
    end
  end
end
