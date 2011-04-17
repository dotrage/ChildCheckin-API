class Person
  include MongoMapper::Document
  
  key :first_name, String, :required => true
  key :last_name, String, :required => true
  timestamps!
  
  one :user_token
end