cli-repl-app  - Reflective ORM design
============
Lighthouse Labs Week3 day2 lab exercise  - Dynamic ORM Enhancement

A ruby command line application to help users manage their contacts through a REPL (Read-eval-print-loop) interface.

This is an enhancement of the csv based cli - creates a reflective orm adding persistance allowing storing and managing contact data in a postgres database

Uses a  reflective meta approach to consuming table column info to drive class and intance calls to the database. 

Limitations: 
Currently this proof of concept is limited to enuerating String type postgres column data.  The models can easily extended to include all column data types by concurrently cataloging the column name and column data type. 

My intention here is to explore Ruby reflection capabilities and build my own orm at the same time. The goal is to completely abstract the work of persisting data in a postgres database. That is the database tables and their columns would drive the model instance action.

The idea is that the orm CRUD is dynamic and created reflectively by connecting to the database, cataloging the tables and their column name. The catalog of table parameters are stored as a class variable in the database Class model. Any request to read or write data to the database are mediated by a sql generation method on the database model instance. The sql generation dynamically generates the required sql string for the required action on the required table.   

gitignore note:
database_config.rb is located in the root directory and should contain the necessary postgres connection parameters
module DatabaseConfig
  class DbConnectParms

    DB_NAME = 'dbname'
    PORT = 5432   #heroku in this case
    USER = 'user'
    HOST = 'host usl'
    PASSWORD = 'password'
    ADAPTER = 'postgresql'
    ENCODING =  'unicode'
    POOL = 5
    MIN_MESSAGES = 'error'

  end
end 
