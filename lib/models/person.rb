class Person
  include MongoMapper::Document
  
  key :first_name, String, :required => true
  key :last_name, String, :required => true
end