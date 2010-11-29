class StatesController < BaseController

  def self.index format
    states = State.aall
    render states, format
  end
  def self.create params, format
    state = State.new
    state.name = params["name"]
    state.country = Country.find(params["country_id"].to_i)
    if state.save
     render state, format
    end
  end

  def self.read params, format
    render State.find(params["id"]), format
  end

  def self.update params, format
    state = State.find(params["id"])
    if state.update_attributes(params)
      render state, format
    end
  end

  def self.delete params
    state = State.find(params["id"])
    state.delete
  end

end
