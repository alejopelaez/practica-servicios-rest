class CountriesController
    
    def self.create params
        country = Country.new(params)
        country.save
    end

    def self.read id
        Country.find(id)
    end

    def self.update params
        country = Country.find(params["id"])
        country.update_attributes(params)
    end

    def self.delete id
        country = Country.find(params["id"])
        country.destroy
    end

end
