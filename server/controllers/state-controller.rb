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
