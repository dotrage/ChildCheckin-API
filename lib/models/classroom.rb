class ClassRoom
  include MongoMapper::Document
  
  key :name, String, :required => true
  
  many :students
  many :attendences
  
  timestamps!
end