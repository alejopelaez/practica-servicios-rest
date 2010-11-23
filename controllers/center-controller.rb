class CentersController
    
    def create params
        center = Center.new
        center.name = params["name"]
        center.city = City.find(params["city_id"].to_i)
        center.save
    end

    def read params       
    end

    def update params
    end

    def delete params
    end

end
