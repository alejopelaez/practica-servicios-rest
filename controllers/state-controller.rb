class StatesController
    
    def create params
        state = State.new
        state.name = params["name"]
        state.country = Country.find(params["country_id"].to_i)
        state.save
    end

    def read params       
    end

    def update params
    end

    def delete params
    end

end
