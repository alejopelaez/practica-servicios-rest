class CitiesController
    
    def create params
        city = City.new
        city.name = params["name"]
        city.state = State.find(params["state_id"].to_i)
        city.save
    end

    def read params       
    end

    def update params
    end

    def delete params
    end

end
