class UserToken
  include MongoMapper::Document
  
  #before_create :generate_user_token ... callback isn't working >:-/
  
  key :user_token, String, :required => true
  key :person_id, ObjectId, :required => true
  timestamps!
  
  belongs_to :person
  
  #private
  def generate_user_token
    self.user_token = Digest::SHA1::hexdigest(rand(36**8).to_s(36))
  end
end