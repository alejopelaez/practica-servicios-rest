class CentersController < BaseController
  def self.index format
    centers = Center.all
    render centers, format
  end
  def self.create params, format
    center = Center.new
    center.name = params["name"]
    center.city = City.find(params["city_id"].to_i)
    if center.save
      render center, format
    end
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
