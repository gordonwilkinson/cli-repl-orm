require 'pry'
require 'pg'
require './contact_database'


class DatabaseTable 

  @@db_conn = nil
  @@attr_db_fields = nil 
  @@table_name = nil
  @@attr_db_fields = []
  @@class_name  = nil 


  attr_accessor  :attr_db_fields,  :id



  def from_hash()
    #TBD
    # this.instance_variable_set(@firstname, 'Billy') 
  end

  def to_hash()
    #TBD
    # return = this.instance_variables.each_with_object({}) 
    # { |var,hash| hash[var.to_s.delete("@")] = this.instance_variable_get(var) } 

  end

  def destroy 
    #TBD  
    #should employ a checked exception 
    #return nil if not found... 

  end


  def display_contents

  end


  def save 

    if @id
      sql_str = sql_update 
    else
      sql_str = sql_insert  
    end      

    @@db_conn = ContactDatabase.connection
    @@db_conn.exec(sql_str)    

  end  


  def sql_update
    # eg sql_str =  "UPDATE table SET  col1 = 'col1val', col2 = 'col2val' WHERE id = instance_id;"   

    self.get_table_col_names(false)

    sql_str  =  "UPDATE #{@@table_name} SET "

    @@attr_db_fields.each do |col| 
      if col != 'id'
        sql_str <<  "#{col} = "
        sql_str << "'" 
        sql_str <<  "#{self.instance_variable_get('@' << col)}"
        sql_str << "'" 
        sql_str <<   ","
        sql_str << " "
      end   
    end
    sql_str = sql_str[0..-3]

    sql_str << " "
    sql_str << " WHERE "
    sql_str << " "
    sql_str << " id = "
    sql_str << " "
    sql_str << " #{self.instance_variable_get('@id')}"


     sql_str << ";" 
    
  end

  def sql_insert
    #example output: "INSERT into table (col_name1, colname2) values ('value1', 'value2');"    
  
    self.get_table_col_names(false)

    sql_str  =  "INSERT  INTO #{@@table_name}  "

    sql_str << "("
    @@attr_db_fields.each do |col| 
      if col != 'id'
        sql_str << "#{col} "
        sql_str << "," 
      end   
    end

    sql_str = sql_str[0..-2]
    sql_str << ")"
    sql_str << " "
    sql_str << " VALUES"
    sql_str << " "
    sql_str << "("

    @@attr_db_fields.each do |col| 
      if col != 'id'
        sql_str << "'"
        sql_str <<  "#{self.instance_variable_get('@' << col)}"
        sql_str << "'"
        sql_str << " "
        sql_str <<  ","
        sql_str << " "
      end
    end
    
    sql_str = sql_str[0..-3]
    sql_str << ")"
    sql_str << ";" 
    
  end

  def get_tbl_column_names_sql
    sql_str = "SELECT column_name FROM information_schema.columns WHERE table_name='#{@@table_name}';"
  end


  def get_table_col_names(include_id)

    if @@attr_db_fields == nil || @@attr_db_fields.empty?
      @@db_conn = ContactDatabase.connection 
      sql_str = get_tbl_column_names_sql

      table_columns = @@db_conn.exec(get_tbl_column_names_sql)

      table_columns.each do |column| 
        if column['column_name'] != 'id'
        #   # puts column['column_name']  
          @@attr_db_fields << column['column_name']
        else
          if include_id
             @@attr_db_fields << column['column_name']
          end   
        end     
      end
    end    
  end

  
  class << self


    def find(index)
      
      sql_str = "SELECT * FROM #{@@table_name} WHERE id = #{index.to_i};"
      @@db_conn = ContactDatabase.connection
      pg_query_result =  @@db_conn.exec(sql_str) 

      curr_class = Object.const_get(@@class_name)

      find_obj = curr_class.new('','','','')

      find_obj.get_table_col_names(true)
      
      pg_query_result.each do |row|
        row.each do |colname, colvalue|
          find_obj.instance_variable_set('@' << colname, colvalue) 
        end    
      end

      return find_obj

    end
 
    def all
       sql_str = "SELECT * FROM #{@@table_name}; "
       @@db_conn = ContactDatabase.connection
       @@db_conn.exec(sql_str)  
    end

    
    def  find_all_by_lastname(name) 
      #TBD
      # contacts = Contact.find_all_by_lastname('Wilkinson')
      #   contacts.each do |c|
      #   puts c
      # end
    end

    def find_by_email(email)
      #TBD
      #return a single contact .. where found.. 
    end  

  end

end