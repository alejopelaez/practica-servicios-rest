class CitiesController
    
    def create params
        city = City.new
        city.name = params["name"]
        city.state = State.find(params["state_id"].to_i)
        city.save
    end

    def read params
        City.find(params["id"])
    end

    def update params
        city = City.find(params["id"])
        city.update_attributes(params)
    end

    def delete params
        city = City.find(params["id"])
        city.delete
    end

end
