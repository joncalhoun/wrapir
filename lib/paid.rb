require 'wrapir'

class Paid < Wrapir
  use_middleware Paid::CustomAuth
  use_middleware Paid::DefaultHeaders
  use_middleware Paid::ErrorHandler

  # use_parser Wrapir::JsonParser ??

  endpoints path: 'https://api.paidapi.com/v0' do
    resource :accounts, only: [:retrieve]
    resources :customers, except: [:delete] do
      collection do
        get :by_external_id, params: [:external_id], constructor: :customer
      end
      member do
        post :generate_invoices, constructor: :invoices_list
        resources :transactions, only: [:all]
      end
    end
    resources :events, only: [:retrieve, :all]
    resources :invoices, except: [:create, :delete] do
      member do
        post :issue
        post :mark_as_paid
      end
    end
    resources :plans, except: [:delete]
    resources :subscriptions, only: [:retrieve, :create, :all] do
      member do
        post :cancel
      end
    end
    resources :transactions do
      member do
        post :mark_as_paid
        post :refund, path: '/refunds'
      end
    end
  end
end

paid.customers.all
paid = Paid.new(username, password)
customer = paid.customers.retrieve(1)

paid.customers # CustomersEndpoint
.retrieve(1) # Customer.retrieve(1, client)


paid.authenticator.apply(api_method)

module ApiMethodMod

  def apply(api_method)
end
