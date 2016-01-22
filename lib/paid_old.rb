require 'wrapir'

class Paid < Wrapir
  use_middleware :CustomAuth
  use_middleware :DefaultHeaders

  # resources :account, :customer, :event, :invoice, :plan, :subscription, :transaction

  endpoints do
    # Default path will be /accounts
    # Default methods will be:
    # 1. GET / - accounts.all
    # 4. POST / - accounts.create
    # 2. GET /:id - accounts.retrieve
    # 3. PUT /:id - accounts.update
    # 5. DELETE /:id - accounts.delete

    resources :accounts do
      member do
        # Will create: GET /accounts/:id/customers in the accounts endpoint as
        # accounts_endpoint.all_customers(account_id)
        resources :customers, only: [:index]
      end
    end
    resources :
      collection path: ''
    end
    resource :accounts, only: [:retrieve] do
      collection do
        get '', as: :index
      end

      member path: '/:id' do
        get '/customers', as: :customers, class: :Customer
      end
    end
  end
  # api_base_url 'https://api.paidapi.com/v0'
  resources [
    :Customer
  ]

  api_endpoints do
    endpoint :Accounts do
      get "/", as: :all
      get "/:id", as: :retrieve
    end
  end
    :Accounts,
    :Customers,
    :Events,
    :
  ]
end

class CustomAuth < Wrapir::HTTPBasicAuth
  def initialize(hash)
    @username = hash[:api_key]
    @password = ""
  end
end

class HTTPBasicAuth < Wrapir::Middleware
  def initialize(hash)
    @username = hash[:username]
    @password = hash[:password]
  end

  def apply(api_method)
    encoded = Base64.encode64("#{@username}:#{@password}")
    api_method.headers.apply({
      "Authorization" => "Basic #{encoded}"
    })
  end
end

class Paid::DefaultHeaders < Wrapir::Middleware
  def initialize(hash)
  end

  def apply(api_method)
    api_method.headers.apply({
      ruby_version: RUBY_VERSION,
      api_version: "v0"
    })
  end
end

paid = Paid.new(username, password)
customer = paid.customers.retrieve(1)

paid.customers # CustomersEndpoint
.retrieve(1) # Customer.retrieve(1, client)


paid.authenticator.apply(api_method)

module ApiMethodMod

  def apply(api_method)
end
