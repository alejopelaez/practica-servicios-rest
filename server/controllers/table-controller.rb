class TablesController
    
    def create params
        table = Table.new
        table.name = params["name"]
        table.center = Center.find(params["center_id"].to_i)
        table.save
    end

    def read params
        Table.find(params["id"])
    end

    def update params
        table = Table.find(params["id"])
        table.update_attributes(params)
    end

    def delete params
        table = Table.find(params["id"])
        table.delete
    end

end
