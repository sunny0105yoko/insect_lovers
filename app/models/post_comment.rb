class PostComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :list
  
  validates :comment, presence: true, length: { maximum: 140 }
end
