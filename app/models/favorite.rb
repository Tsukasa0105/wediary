class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :memo
  
  validates :memo_id, uniqueness: { scope: :user_id }

end
