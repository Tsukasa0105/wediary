# frozen_string_literal: true

class UserToGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :group_id, uniqueness: { scope: :user_id }
end
