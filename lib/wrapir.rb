require 'wrapir/api_method'
require 'wrapir/client'
require 'wrapir/endpoint'
require 'wrapir/endpoint_builder'
require 'wrapir/endpoint_method_builder'
require 'wrapir/path_builder'

class Wrapir
  attr_access :options

  def self.endpoints(url, opts = {}, &block)
    @options = default_options.merge(opts)
    validate!
  end

  # By default, the following endpoint methods are created:
  #
  # all - this typically hits the index of a resource
  #   verb: :get
  #   path: '/#{resources_name}'
  #
  # retrieve - this typically retrieves a single resource
  #   verb: :get
  #   path: '/#{resources_name}/:id'
  #
  # create - this typically retrieves a single resource
  #   verb: :post
  #   path: '/#{resources_name}'
  #
  # update - this typically updates a single resource
  #   verb: :put
  #   path: '/#{resources_name}/:id'
  #
  # delete - this typically deletes a single resource
  #   verb: :delete
  #   path: '/#{resources_name}/:id'
  #
  def self.resources()

  def self.validate!
    raise ArgumentError.new('Invalid options. HINT: Make sure you provided a valid url.') unless valid?
  end

  def self.valid?
    # TODO(jon): Add URI parsing in here.
    return false unless @options[:url] && @options[:url].is_a?(String)
    true
  end
end
