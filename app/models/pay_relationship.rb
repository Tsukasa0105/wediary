class PayRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :pay_record

  # validates :user_id, presence: true
  # validates :pay_record_id, presence: true
end
