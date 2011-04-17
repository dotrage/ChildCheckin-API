class Attendance
  include MongoMapper::Document
  
  key :student_id, ObjectId, :required => true
  key :present, Boolean, :required => true
  key :class_date, Date, :required => true
  
  timestamps!
end