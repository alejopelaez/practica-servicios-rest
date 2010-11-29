class CitiesController
  def self.index format
    cities = City.all
    case format
    when 'json'
      cities.to_json
    when 'xml'
      cities.to_xml
    end
  end
  def self.create params
    city = City.new
    city.name = params["name"]
    city.state = State.find(params["state_id"].to_i)
    city.save
    case format
    when 'json'
      city.to_json
    when 'xml'
      city.to_xml
    end
  end

  def self.read params
    City.find(params["id"])
  end

  def self.update params
    city = City.find(params["id"])
    city.update_attributes(params)
  end

  def self.delete params
    city = City.find(params["id"])
    city.delete
  end

end
