class Memo < ApplicationRecord
  belongs_to :event
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  validates :title, presence: true
end
