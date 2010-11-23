class TablesController
    
    def create params
        table = Table.new
        table.name = params["name"]
        table.center = Center.find(params["center_id"].to_i)
        table.save
    end

    def read params       
    end

    def update params
    end

    def delete params
    end

end
