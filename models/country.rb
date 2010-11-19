require 'rubygems'  
require 'active_record'
require 'state'

# For debugging, this should be placed at the start of the aplication
# ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "practica")

class Country < ActiveRecord::Base
    has_many :states

    def self.getCountry(id)
        Country.find(id)
    end

    def get_totals
        if @totales.nil?
            @totales ||= {:piedad => 0, :reyes => 0, :jojoy => 0}
            states.each do |s|
                s.get_totals.each_pair do |c, v|
                    @totales[c] += v
                end
            end
        end
        @totales
    end
end
