require 'pry'
require 'pg'
require './database_config'

class ContactDatabase 

  @@db_conn = nil


  class << self

    def connection
      if @@db_conn == nil 
        begin

          @@db_conn = PG.connect(
              dbname: DatabaseConfig::DbConnectParms::DB_NAME,
              port: DatabaseConfig::DbConnectParms::PORT,
              user: DatabaseConfig::DbConnectParms::USER,
              host: DatabaseConfig::DbConnectParms::HOST,
              password: DatabaseConfig::DbConnectParms::PASSWORD
          )

        rescue PG::ConnectionBad => e 

          puts  "Error encountered attempting to connect to db. Error: #{e.message}"
          @@db_conn = nil
        end    
      end 
      
      return @@db_conn
    end
     
    def db_connected?
      if @@db_conn != nil 
        true unless @@db_conn.status == PG::ConnectionBad 
      end
    end

    def db_close_connection
      @@db_conn.close 
      @@db_conn = nil 
    end

  end
end