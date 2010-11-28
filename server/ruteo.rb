require './boot/gemas.rb'
require './boot/libs.rb'
require './boot/models.rb'
require './boot/controls.rb'

ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "practica")

class RuteoApp
  include DSL
  include Template
  @@params = []
  get '/graphs/:where/:piedad/:jojoy/:reyes' do |w , p, j, r|
    @bar_chart = Grapher.bar_chart("Resultados en #{w}",{:Piedad => [[p.to_i],Grapher::RED], 
                                     :Jojoy => [[j.to_i],Grapher::BLUE],
                                     :Reyes => [[r.to_i],Grapher::GREEN]})
    "graphs/show"
  end
    
  post '/results' do 
    @country = CountriesController.show(@@params["key"])    
    @totales = @country.get_totals
    
    "countries/result2"
  end
  
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

  get '/' do
    "index"
  end

  # Create services, the parameters are passed in the request body
  post '/country' do CountriesController.create(@@params) end
  post '/state'   do StatesController.create(@@params) end
  post '/city'    do CitiesController.create(@@params) end
  post '/center'  do CentersController.create(@@params) end
  post '/table'   do TablesController.create(@@params) end

  # Read services
  # Not finished yet, must do something with ther resource
  get 'country/:id' do |id| CountriesController.read(id) end
  get 'state/:id'   do |id| StatesController.read(id) end
  get 'city/:id'    do |id| CitiesController.read(id) end
  get 'center/:id'  do |id| CentersController.read(id) end
  get 'table/:id'   do |id| TablesController.read(id) end

  # Updatee services, the parameters are passed in the request body
  put '/country' do CountriesController.update(@@params) end
  put '/state'   do StatesController.update(@@params) end
  put '/city'    do CitiesController.update(@@params) end
  put '/center'  do CentersController.update(@@params) end
  put '/table'   do TablesController.update(@@params) end

  # Delete services
  delete 'country/:id' do |id| CountriesController.delete(id) end
  delete 'state/:id'   do |id| StatesController.delete(id) end
  delete 'city/:id'    do |id| CitiesController.delete(id) end
  delete 'center/:id'  do |id| CentersController.delete(id) end
  delete 'table/:id'   do |id| TablesController.delete(id) end

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
    route,vals = self.class.routes.match method, path
    if route.nil?
      return [404, {'Content-Type' => 'text/html'}, '404 page not found']
    else
      if(route.path.extension == "json")
          return [200, {'Content-Type' => 'application/json'}, callback_response(@@params["callback"],route.action.call(*vals))]
      elsif(route.path.extension == "xml")
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
