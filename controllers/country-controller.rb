class CountriesController
    
    def create params
        country = Country.new
        country.name = params["name"]
        country.save
    end

    def read id
        Country.find(id)
    end

    def update params
    end

    def delete id
        
    end

end
