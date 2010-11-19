require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "practica")

ActiveRecord::Schema.define do
    create_table :countries do |table|
        table.column :name, :string
    end

    create_table :states do |table|
        table.column :name, :string
        table.column :country_id, :int
    end

    create_table :cities do |table|
        table.column :name, :string
        table.column :state_id, :int
    end

    create_table :centers do |table|
        table.column :name, :string
        table.column :city_id, :int
    end

    create_table :tables do |table|
        table.column :name, :string
        table.column :piedad, :int
        table.column :reyes, :int
        table.column :jojoy, :int
        table.column :center_id, :int
    end
end
