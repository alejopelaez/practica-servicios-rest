require 'rubygems'
require 'active_record'
require 'country'
ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "practica")

c = Country.first
puts c.get_totals.inspect
