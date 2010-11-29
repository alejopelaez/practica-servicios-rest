class StatesController

  def self.index format
    states = State.aall
    case format
    when 'json' 
      states.to_json
    when 'xml'
      states.to_xml
    end
  end
  def self.create params, format
    state = State.new
    state.name = params["name"]
    state.country = Country.find(params["country_id"].to_i)
    state.save
    case format
    when 'json' 
      state.to_json
    when 'xml'
      state.to_xml
    end
  end

  def self.read params
    State.find(params["id"])
  end

  def self.update params
    state = State.find(params["id"])
    state.update_attributes(params)
  end

  def self.delete params
    state = State.find(params["id"])
    state.delete
  end

end
