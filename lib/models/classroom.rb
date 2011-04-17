class ClassRoom
  include MongoMapper::Document
  
  key :name, String, :required => true
  timestamps!
  
  belongs_to :teacher
  many :students
  many :attendences
end