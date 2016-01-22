require 'set'

class Wrapir
  class PathBuilder

    # Takes a path like
    #   '/cards/:id'
    # and a hash of values like
    #   {
    #     id: 'card_abc123'
    #   }
    #
    # and converts it into
    #   '/cards/card_abc123'
    #
    # Requirements:
    #   1. All keys in path_values *must* be symbols.
    #
    def self.build(path, path_values = {})
      ret = path.dup
      if ret.include?(":")
        matches = ret.scan(/:([^\/]*)/).flatten.map(&:to_sym)
        missing = Set.new(matches)

        matches.each do |match|
          value = path_values[match]
          missing.delete(match) unless value.nil?
          ret.sub!(match.inspect, "#{value}")
        end

        if missing.any?
          raise ArgumentError.new("One or more of the keys in the path didn't have values provided. The following values are missing: #{missing.to_a.join(', ')}. HINT: Verify that the keys in path_values are symbols.")
        end
      end
      ret
    end

  end
end
