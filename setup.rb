require 'pry'
require 'active_record'
# require './database_config'
require_relative 'lib/contact'
 
module DatabaseConfig
  class DbConnectParms

    DB_NAME = 'dc19q1n7sfulf3'
    PORT = 5432
    USER = 'ajtmokfsdwnpqc'
    HOST = 'ec2-54-235-250-41.compute-1.amazonaws.com'
    PASSWORD = 'GWZxeEILP71Yk6aEJvUIVVdFsM'
    ADAPTER = 'postgresql'
    ENCODING =  'unicode'
    POOL = 5
    MIN_MESSAGES = 'error'

  end
end 

# Output messages from AR to STDOUT
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "Establishing connection to database ..."
ActiveRecord::Base.establish_connection(
  adapter: DatabaseConfig::DbConnectParms::ADAPTER,
  encoding: DatabaseConfig::DbConnectParms::ENCODING,
  pool: DatabaseConfig::DbConnectParms::POOL,
  database: DatabaseConfig::DbConnectParms::DB_NAME,
  username: DatabaseConfig::DbConnectParms::USER,
  password: DatabaseConfig::DbConnectParms::PASSWORD,
  host: DatabaseConfig::DbConnectParms::HOST,
  min_messages: DatabaseConfig::DbConnectParms::MIN_MESSAGES
)

