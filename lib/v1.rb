# TODO(jon): Make this work!

class Paid < Wrapir
  endpoints 'https://api.paidapi.com/v0' do
    resources :invoices
  end
end


# 1. Create Paid::InvoicesEndpoint < Endpoint
# 2. Create Paid::Invoice (this will eventually allow any params)
# 3. Add GET /invoices method and return json (not even using invoice class)



send(:define_method, #{method_name}) do |#{arguments}params = {}, headers = {}|

  method = Method.new()
end
def #{method_name}(params={}, headers={}, url_params = {})
  method = Method.new(#{verb}, #{path}, {
    params: params,
    headers: headers,
    url_params: url_params
  })
  @client.execute(method)
end


# NOTE: Method.new needs to grab a blob of args and set the last 2 as params and headers. the rest are
class Endpoint
  def build_hash(method_name, *values)
    ret = {}
    method = self.class.instance_method(method_name)
    method.parameters[0..-3].map(&:last).each_with_index do |arg, i|
      ret[arg] = values[i]
    end
    ret
  end
end

class Jon < Endpoint
end

klass = Jon
name = :retrieve
arguments = [:id]
verb = :get
path = '/invoices/:id'

code = <<CODE
#{klass}.send(:define_method, #{name.inspect}) do |#{arguments.map{ |a| "#{a}, " }.join}params = {}, headers = {}|
  path_values = build_hash(#{name.inspect}#{arguments.map{ |a| ", #{a}" }.join})
  method = ApiMethod.new(#{verb.inspect}, '#{path}', {
    path_values: path_values,
    params: params,
    headers: headers
  })
  @client.execute(method)
end
CODE

puts code
