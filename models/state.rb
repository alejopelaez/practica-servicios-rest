require 'rubygems'  
require 'active_record'

# For debugging, this should be placed at the start of the aplication
# ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "practica")

class State < ActiveRecord::Base
    belongs_to :country
    has_many :cities

    def self.getState(id)
        State.find(id)
    end

    def get_totals
        if @totales.nil?
            @totales ||= {:piedad => 0, :reyes => 0, :jojoy => 0}
            cities.each do |s|
                s.get_totals.each_pair do |c, v|
                    @totales[c] += v
                end
            end
        end
        @totales
    end
end


