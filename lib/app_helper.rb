
def safely_require(file)
 
require_relative file
rescue LoadError
  # ignore
end

# safely_require 'application'
# safely_require 'contact_database'

