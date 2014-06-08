require 'pry'
require 'pg'
 require './contact_database'
 require './database_table'

class Contact < ActiveRecord::Base 

  @@table_name = 'contacts'
  @@class_name = 'Contact'

  attr_accessor :firstname, :lastname, :email, :tel_number

  def initialize(firstname, lastname, email, tel_number)
    #TODO:  add creation_date as Time.now.to_a.to_s

    @firstname = firstname
    @lastname = lastname
    @email = email 
    @tel_number = tel_number
    @id = nil
    
  end
 
end
