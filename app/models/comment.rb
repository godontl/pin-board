class Comment < ApplicationRecord
  belongs_to :pin_comments
  belongs_to :user
  belongs_to :post
  validates :body, presence: true, length: { maximum: 10 }
end
