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
