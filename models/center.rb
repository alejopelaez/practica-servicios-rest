require 'rubygems'  
require 'active_record'
require 'city'
require 'table'

# For debugging, this should be placed at the start of the aplication
# ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "practica")

class Center < ActiveRecord::Base
    belongs_to :city
    has_many :tables

    def self.getCenter(id)
        Center.find(id)
    end

    def get_totals
        if @totales.nil?
            @totales ||= {:piedad => 0, :reyes => 0, :jojoy => 0}
            tables.each do |s|
                s.get_totals.each_pair do |c, v|
                    @totales[c] += v
                end
            end
        end
        @totales
    end
end


