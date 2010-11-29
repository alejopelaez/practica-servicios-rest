class CitiesController < BaseController
  def self.index format
    cities = City.all
    render cities, format
  end
  def self.create params, format
    city = City.new
    city.name = params["name"]
    city.state = State.find(params["state_id"].to_i)
    if city.save
      render city, format
    end
  end

  def self.read id, format
    render City.find(id), format
  end

  def self.update params, format
    city = City.find(params["id"])
    if city.update_attributes(params)
      render city, format
    end
  end

  def self.delete id
    city = City.find(id)
    city.delete
  end

end
