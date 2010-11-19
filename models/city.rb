require 'rubygems'  
require 'active_record'
require 'state'
require 'center'

# For debugging, this should be placed at the start of the aplication
# ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "practica")

class City < ActiveRecord::Base
    belongs_to :state
    has_many :centers

    def self.getCity(id)
        City.find(id)
    end

    def get_totals
        if @totales.nil?
            @totales ||= {:piedad => 0, :reyes => 0, :jojoy => 0}
            centers.each do |s|
                s.get_totals.each_pair do |c, v|
                    @totales[c] += v
                end
            end
        end
        @totales
    end
end


