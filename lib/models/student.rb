require 'person'

class Student < Person
  key :parent_id, ObjectId
  belongs_to :parent
  
  key :classroom_id, ObjectId
  belongs_to :classroom
end