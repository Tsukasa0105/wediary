# frozen_string_literal: true

class InitialPayRelationship < ApplicationRecord
  belongs_to :initial_user, class_name: 'User', optional: true
  belongs_to :pay_record, optional: true

  validates :initial_user_id, presence: true
  validates :pay_record_id, presence: true
end
