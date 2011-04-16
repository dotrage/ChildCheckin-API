require 'system_timer'
require 'mongo_mapper'

require 'lib/models/attendance'
require 'lib/models/classroom'
require 'lib/models/parent'
require 'lib/models/school'
require 'lib/models/student'
require 'lib/models/teacher'

MongoMapper.connection = Mongo::Connection.new('flame.local.mongohq.com', 27057, :pool_size => 5, :timeout => 5)
MongoMapper.database = 'childcheckin'
MongoMapper.database.authenticate('app', 'oWf5_Ly')

class Hash
  def recursive_delete(key)
    recursive_delete_(self, key)
  end
  
  def recursive_delete_(hash, key)
    hash.delete(key)
    hash.each_value do |value|
      recursive_delete(value, key) if value.is_a? Hash
    end
  end
end