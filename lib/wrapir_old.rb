require 'byebug'

class Wrapir
  def self.endpoints(url, opts = {}, &block)
    @endpoint_options = {
      url: url
    }.merge(opts)
    yield
  end

  def self.resource(name, opts = {}, &block)
    puts "In the resource declaration with #{name} #{opts} and #{block_given?}"
    puts "Globals are: #{@endpoint_opts} and #{@endpoint_url}"
  end

  # All - GET /#{name}
  # Retrieve - GET /#{name}/:id
  # Create - POST /#{name}
  # Update - PUT /#{name}/:id
  # Delete - DELETE /#{name}/:id
  def self.resources(name, opts = {}, &block)
    EndpointGenerator.declare(self, name, opts, &block)
  end

  def self.inherited(subclass)
    # TODO(jon): Remove this if we don't end up using it.
    super
  end

private

end

class Wrapir::EndpointGenerator
  def self.declare(base_class, name, opts = {}, &block)
    opts = {
      only: [:retrieve],
      base_path: "/#{name}"
    }.merge(opts)

    endpoint_class = declare_class(base_class, name)
    declare_methods(endpoint_class, opts, &block)
  end

  def self.declare_class(base_class, name)
    endpoint_name = "#{base_class}::#{name}_endpoint".split("_").map(&:capitalize).join
    eval class_code(endpoint_name)
    Object.const_get(endpoint_name)
  end

  def self.declare_methods(klass, opts = {}, &block)
    # TODO(jon): Use options to limit eventually
    # opts[:only].each do |method|
    #   send("declare_#{method}", klass, opts)
    # end
    declare_retrieve(klass, opts)
  end

  def self.declare_retrieve(klass, opts = {})
    declare_method(klass, :retrieve, :get, opts.merge(
      arguments: [:id],
      path: "#{opts[:base_path]}/:id"
    ))
  end

  def self.declare_method(klass, name, verb, opts)
   code = method_code(name, verb, opts)
   klass.send(:define_method, :retrieve) do |id|

    end
  end

private

  # This is typically something like
  def self.class_code(name)
    code = <<ENDPOINT
      class ::#{name} < #{self.name}
      end
ENDPOINT
  end

  def self.method_code(name, verb, opts)
    arguments_string = arguments.map{ |arg| "#{arg}, " }.join
    code = <<METHOD
      def #{name}(#{arguments_string}params={}, headers={})
        method = Method.new(#{verb.inspect}, #{path}, *args)
        @client.execute(method)
      end
METHOD
  end
end

class JonTest < Wrapir
  endpoints 'https://api.paidapi.com/v0' do
    # resource :account, only: [:retrieve]
    resources :invoices do
    end
  end
end

#   use_middleware Paid::CustomAuth
#   use_middleware Paid::DefaultHeaders
#   use_middleware Paid::ErrorHandler

#   # use_parser Wrapir::JsonParser ??

#   endpoints path: 'https://api.paidapi.com/v0' do
#     resource :accounts, only: [:retrieve]
#     resources :customers, except: [:delete] do
#       collection do
#         get :by_external_id, params: [:external_id], constructor: :customer
#       end
#       member do
#         post :generate_invoices, constructor: :invoices_list
#         resources :transactions, only: [:all]
#       end
#     end
#     resources :events, only: [:retrieve, :all]
#     resources :invoices, except: [:create, :delete] do
#       member do
#         post :issue
#         post :mark_as_paid
#       end
#     end
#     resources :plans, except: [:delete]
#     resources :subscriptions, only: [:retrieve, :create, :all] do
#       member do
#         post :cancel
#       end
#     end
#     resources :transactions do
#       member do
#         post :mark_as_paid
#         post :refund, path: '/refunds'
#       end
#     end
#   end
# end

# paid.customers.all
# paid = Paid.new(username, password)
# customer = paid.customers.retrieve(1)

# paid.customers # CustomersEndpoint
# .retrieve(1) # Customer.retrieve(1, client)


# paid.authenticator.apply(api_method)

# module ApiMethodMod

#   def apply(api_method)
# end
