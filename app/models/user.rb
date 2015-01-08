class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :password_hash, type: String

  has_many :pitches
  
  def password=(unencrypted_password)
    self.password_hash = BCrypt::Password.create(unencrypted_password)
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_hash) == unencrypted_password
      return self
    else
      return false
    end
  end

end
