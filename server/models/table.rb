require 'rubygems'  
require 'active_record'

# For debugging, this should be placed at the start of the aplication
# ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "practica")

class Table < ActiveRecord::Base
    belongs_to :center

    def self.getTable(id)
        Table.find(id)
    end

    def get_totals
        @totales ||= {:piedad => piedad, :reyes => reyes, :jojoy => jojoy}
    end
end


