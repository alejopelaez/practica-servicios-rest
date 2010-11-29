class CountriesController < BaseController

  def self.index format
    countries = Country.all
    render countries, format
  end
  def self.create params, format
    country = Country.new(params)
    if country.save
      render country, format
    end
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
