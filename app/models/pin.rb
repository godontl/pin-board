class Pin < ApplicationRecord
 acts_as_votable
 belongs_to :user
 validates :title, presence: true, length: { minimum: 2 }
 has_many :comments

 has_attached_file :image, styles: { medium: "300x300>" }
 validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
