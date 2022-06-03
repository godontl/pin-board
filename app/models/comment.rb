class Comment < ApplicationRecord
  belongs_to :pin
  belongs_to :user
  #validates :body, length: { minimum: 2 }
end
