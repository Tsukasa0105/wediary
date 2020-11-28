class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :group_user_permissions, dependent: :destroy
  has_many :request_users, through: :group_users, source: :user
  has_many :invited_users, through: :group_user_permissions, source: :user
  has_many :events, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :maps, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  validates :key, presence: true, uniqueness: true

  
  mount_uploader :image, ImageUploader
  
  def joined_users
    self.request_users & self.invited_users
  end
end
