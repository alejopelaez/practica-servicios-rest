require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "practica")

ActiveRecord::Schema.define do
    drop_table :countries
    drop_table :states
    drop_table :cities
    drop_table :centers
    drop_table :tables
end
