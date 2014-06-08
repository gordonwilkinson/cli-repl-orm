require 'pry'

class Contact < ActiveRecord::Base
  def to_s
     "#{@first_name} #{@last_name} #{@email} #{@tel_number} "
  end
 
end
