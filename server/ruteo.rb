require './boot/gemas.rb'
require './boot/libs.rb'
require './boot/models.rb'
require './boot/controls.rb'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "practica")

class RuteoApp
  include DSL
  include Template
  @@params = []

  # Service that returns a json representing the results tree
  # of the given country
  get 'results/:cname.json' do |cname|
    country = Country.find_by_name(cname)
    country.to_json(:include => {:states => {:include => {:cities => {
                    :include => {:centers => {:include => :tables}}}}}})
  end

  # Service that returns a json with the totals for
  # the given country
  get 'totals/:cname.json' do |cname|
    country = Country.find_by_name(cname)
    "{#{country.get_totals.map{|k,v| "\"#{k}\":#{v}"}.join(',')}}"
  end 

  # All
  get '/country.:format' do | format |
    CountriesController.index format
  end
  get '/state.:format'   do | format |
    StatesController.index format 
  end
  get '/city.:format'    do | format |
    CitiesController.index format
  end
  get '/center.:format'  do  | format |
    CentersController.index format
  end
  get '/table.:format'   do | format |
    TablesController.index format
  end


  # Create services, the parameters are passed in the request body
  post '/country.:format' do | format |
    CountriesController.create(@@params, format) 
  end
  post '/state.:format'   do | format |
    StatesController.create(@@params, format) 
  end
  post '/city.:format'    do  | format |
    CitiesController.create(@@params, format) 
  end
  post '/center.:format'  do | format |
    CentersController.create(@@params, format) 
  end
  post '/table'   do | format |
    TablesController.create(@@params, format) 
  end

  # Read services
  # Not finished yet, must do something with ther resource
  get '/country/:id' do |id| CountriesController.read(id) end
  get '/state/:id'   do |id| StatesController.read(id) end
  get '/city/:id'    do |id| CitiesController.read(id) end
  get '/center/:id'  do |id| CentersController.read(id) end
  get '/table/:id'   do |id| TablesController.read(id) end

  # Updatee services, the parameters are passed in the request body
  put '/country' do CountriesController.update(@@params) end
  put '/state'   do StatesController.update(@@params) end
  put '/city'    do CitiesController.update(@@params) end
  put '/center'  do CentersController.update(@@params) end
  put '/table'   do TablesController.update(@@params) end

  # Delete services
  delete '/country/:id' do |id| CountriesController.delete(id) end
  delete '/state/:id'   do |id| StatesController.delete(id) end
  delete '/city/:id'    do |id| CitiesController.delete(id) end
  delete '/center/:id'  do |id| CentersController.delete(id) end
  delete '/table/:id'   do |id| TablesController.delete(id) end

  # If the request passed a callback, answer in the appropiate way.
  # Or else, answer normally.
  def callback_response(callback,response)
    if callback.nil?
      response
    else
      callback + "(" + response + ")"
    end
  end

  def call(env)
    path = env["PATH_INFO"]
    method = env['REQUEST_METHOD']
    @@params = Rack::Request.new(env).params
    route,vals, extension = self.class.routes.match method, path
    if extension
      vals << extension
    end
    if route.nil?
      return [404, {'Content-Type' => 'text/html'}, '404 page not found']
    else
      if(extension == "json")
        return [200, {'Content-Type' => 'application/json'}, callback_response(@@params["callback"],route.action.call(*vals))]
      elsif(extension == "xml")
        return [200, {'Content-Type' => 'application/xml'}, callback_response(@@params["callback"],route.action.call(*vals))]
      else
        begin
          return [200, {'Content-Type' => 'text/html'}, self.class.htmlize(self.class.erb(route.action.call(*vals)))]
        rescue Exception => e
          return [500, {'Content-Type' => 'text/html'}, "500 internall server error,#{e}"]
        end
      end
    end
  end

end
