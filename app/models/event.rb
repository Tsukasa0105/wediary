# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :map
  has_many :photos, dependent: :destroy
  has_many :pay_records, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true
  validates :start_time, presence: true

  mount_uploader :image, ImageUploader

  def save_notification_new_event(current_user, visited_id)
    notification = current_user.active_notifications.new(
      group_id: group_id,
      event_id: id,
      visited_id: visited_id,
      action: 'new_event'
    )
    notification.checked = true if notification.visiter_id == notification.visited_id
    notification.save if notification.valid?
  end

  def create_notification_new_event(current_user, group)
    joined_users = group.invited_users && group.request_users
    group_users = joined_users.where.not(id: current_user.id).distinct
    group_users.each do |group_user|
      save_notification_new_event(current_user, group_user.id)
    end
  end

  def save_notification_edit_event(current_user, visited_id)
    notification = current_user.active_notifications.new(
      group_id: group_id,
      event_id: id,
      visited_id: visited_id,
      action: 'edit_event'
    )
    notification.checked = true if notification.visiter_id == notification.visited_id
    notification.save if notification.valid?
  end

  def create_notification_edit_event(current_user, group)
    joined_users = group.invited_users && group.request_users
    group_users = joined_users.where.not(id: current_user.id).distinct
    group_users.each do |group_user|
      save_notification_new_event(current_user, group_user.id)
    end
  end
end
