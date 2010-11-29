class CentersController
  def self.index format
    centers = Center.all
    case format
    when 'json'
      centers.to_json
    when 'xml'
      centers.to_xml
    end
  end
  def self.create params
    center = Center.new
    center.name = params["name"]
    center.city = City.find(params["city_id"].to_i)
    center.save
  end

  def self.read params
    Center.find(params["id"])
  end

  def self.update params
    center = Center.find(params["id"])
    center.update_attributes(params)
  end

  def self.delete params
    center = Center.find(params["id"])
    center.delete
  end

end
