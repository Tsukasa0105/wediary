class Memo < ApplicationRecord
  belongs_to :event
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  validates :title, presence: true, length: { maximum: 10 }
  
  def favorite_by(user)
      favorites.find_by(user_id: user.id)
  end
  
end
