class User
  include Mongoid::Document
  field :first_name, type: String
  field :middle_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :password_hash, type: String
  field :company, type: String
  field :about, type: String
  attr_reader :password
  mount_uploader :image, ImageUploader

  has_many :pitches
  
  def password=(unencrypted_password)
    unless unencrypted_password.empty?
      @password = unencrypted_password
      self.password_hash = BCrypt::Password.create(unencrypted_password)
    end
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_hash) == unencrypted_password
      return self
    else
      return false
    end
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, length:{ in: 6..20 }, confirmation: true, on: :create #this will only validate on create # :if => :password, :unless => :password_hash.present?

end
