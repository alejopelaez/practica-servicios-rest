class TablesController

  def self.index format
    tables = Table.all
    case format
    when 'json'
      tables.to_json
    when 'xml'
      tables.to_xml
    end
  end
  def self.create params
    table = Table.new
    table.name = params["name"]
    table.center = Center.find(params["center_id"].to_i)
    table.save
  end

  def self.read params
    Table.find(params["id"])
  end

  def self.update params
    table = Table.find(params["id"])
    table.update_attributes(params)
  end

  def self.delete params
    table = Table.find(params["id"])
    table.delete
  end

end
