# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :user_to_groups, dependent: :destroy
  has_many :request_users, through: :user_to_groups, source: :user
  has_many :group_to_users, foreign_key: 'inviting_group_id', dependent: :destroy
  has_many :invited_users, through: :group_to_users, source: :invited_user
  has_many :events, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :maps, dependent: :destroy

  validates :name, presence: true
  validates :key, presence: true, uniqueness: true

  mount_uploader :image, ImageUploader

  def joined_users
    request_users & invited_users
  end

  def unmember(user)
    user_to_group = user_to_groups.find_by(user_id: user.id)
    user_to_group&.destroy
  end

  def permit_member(user)
    group_to_users.find_or_create_by(invited_user_id: user.id)
  end
end
