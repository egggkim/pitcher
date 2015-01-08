class Pitch
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :description, type: String
  mount_uploader :image, PitchUploader

  belongs_to :user
  embeds_many :comments

  def date_published
    created_at.localtime.strftime("%A, %B %-d, %Y at %l:%M %p")
  end
end
