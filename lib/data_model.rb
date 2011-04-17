require 'system_timer'
require 'mongo_mapper'

require 'lib/models/user_token'
require 'lib/models/attendance'
require 'lib/models/classroom'
require 'lib/models/parent'
require 'lib/models/school'
require 'lib/models/student'
require 'lib/models/teacher'

MongoMapper.connection = Mongo::Connection.new('flame.local.mongohq.com', 27057, :pool_size => 5, :timeout => 5)
MongoMapper.database = 'childcheckin'
MongoMapper.database.authenticate('app', 'oWf5_Ly')