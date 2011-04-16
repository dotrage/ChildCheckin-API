require 'lib/models/person'

class Teacher < Person  
  key :school_id, ObjectId
  belongs_to :school
end