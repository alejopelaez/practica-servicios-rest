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

  def self.read id, format
    render Center.find(id), format
  end

  def self.update params, format
    center = Center.find(params["id"])
    if center.update_attributes(params)
      render center, format
    end
  end

  def self.delete id
    center = Center.find(id)
    center.delete
  end

end
