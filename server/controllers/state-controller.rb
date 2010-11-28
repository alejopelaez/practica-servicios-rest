class StatesController
    
    def create params
        state = State.new
        state.name = params["name"]
        state.country = Country.find(params["country_id"].to_i)
        state.save
    end

    def read params
        State.find(params["id"])
    end

    def update params
        state = State.find(params["id"])
        state.update_attributes(params)
    end

    def delete params
        state = State.find(params["id"])
        state.delete
    end

end
