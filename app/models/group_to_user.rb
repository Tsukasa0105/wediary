class GroupToUser < ApplicationRecord
  belongs_to :invited_user, class_name: "User", foreign_key: 'invited_user_id', optional: true
  belongs_to :inviting_group, class_name: "Group", foreign_key: 'inviting_group_id', optional: true
  
  validates :invited_user_id, presence: true
  validates :inviting_group_id, presence: true
  # validates :group_id, :uniqueness => { :scope => :user_id }
end
