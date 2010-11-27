class CentersController
    
    def create params
        center = Center.new
        center.name = params["name"]
        center.city = City.find(params["city_id"].to_i)
        center.save
    end

    def read params
        Center.find(params["id"])
    end

    def update params
        center = Center.find(params["id"])
        center.update_attributes(params)
    end

    def delete params
        center = Center.find(params["id"])
        center.delete
    end

end
