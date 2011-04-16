require 'person'

class Parent < Person
  key :phone_number, String, :required => true
  key :email, String
  
  many :students
end