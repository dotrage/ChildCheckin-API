class School
  include MongoMapper::Document
  
  key :name, String, :required => true
  key :location, String, :required => true
  
  many :teachers
end