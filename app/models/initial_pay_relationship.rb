class InitialPayRelationship < ApplicationRecord
  belongs_to :initial_user, class_name: "User", optional: true
  belongs_to :pay_record, optional: true
end
