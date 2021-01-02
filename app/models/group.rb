class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :request_users, through: :group_users, source: :user
  has_many :group_user_permissions, foreign_key: 'inviting_group_id', dependent: :destroy
  has_many :invited_users, through: :group_user_permissions, source: :invited_user
  has_many :events, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :maps, dependent: :destroy
  
  validates :name, presence: true
  validates :key, presence: true, uniqueness: true

  
  mount_uploader :image, ImageUploader
  
  def joined_users
    self.request_users & self.invited_users
  end

  def unmember(user) 
      group_user = self.group_users.find_by(user_id: user.id) 
      group_user.destroy if group_user
  end 
  
  def permit_member(user) 
      self.group_user_permissions.find_or_create_by(user_id: user.id) 
  end 
end
