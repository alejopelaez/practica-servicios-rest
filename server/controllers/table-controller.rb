class TablesController < BaseController

  def self.index format
    tables = Table.all
    render tables, format
  end
  def self.create params, format
    table = Table.new
    table.name = params["name"]
    table.center = Center.find(params["center_id"].to_i)
    if table.save
      render table, format
    end
  end

  def self.read id, format
    render Table.find(id), format
  end

  def self.update params, format
    table = Table.find(params["id"])
    if table.update_attributes(params)
      render table, format
    end
  end

  def self.delete id
    table = Table.find(id)
    table.delete
  end

end
