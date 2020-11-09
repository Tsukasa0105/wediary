class PayRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :pay_record
end
