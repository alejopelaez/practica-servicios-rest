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

  def self.read id, format
    render Country.find(id), format
  end

  def self.update params, format
    country = Country.find(params["id"])
    if country.update_attributes(params)
      render country, format
    end
  end

  def self.delete id
    country = Country.find(params["id"])
    country.destroy
  end

end
