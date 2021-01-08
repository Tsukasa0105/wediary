class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    validates :password, allow_blank: true, length: { minimum: 6 }
    has_secure_password
    
    has_many :user_to_groups, dependent: :destroy
    has_many :requested_groups, through: :user_to_groups, source: :group
    has_many :group_to_users, foreign_key: 'invited_user_id', dependent: :destroy
    has_many :inviting_groups, through: :group_to_users, source: :inviting_group
    has_many :relationships, dependent: :destroy
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
    has_many :followers, through: :reverses_of_relationship, source: :user
    has_many :events
    has_many :maps
    has_many :pay_relationships, dependent: :destroy
    has_many :pay_records, through: :pay_relationships
    has_many :initial_pay_relationships, foreign_key: 'initial_user_id', dependent: :destroy
    has_many :initial_pay_records, through: :initial_pay_relationships, source: :pay_record
    
    # フォローについてのメソッド
    def follow(other_user) 
        unless self == other_user 
            self.relationships.find_or_create_by(follow_id: other_user.id) 
        end 
    end 
    
    def unfollow(other_user) 
        relationship = self.relationships.find_by(follow_id: other_user.id) 
        relationship.destroy if relationship 
    end 
    
    def following?(other_user) 
        self.followings.include?(other_user) 
    end
        
    def friends
      self.followings & self.followers
    end
    
    def friend?(other_user)
        self.followings.include?(other_user) && other_user.followings.include?(self)
    end
    
    def total_followers 
        self.followers.count 
    end 
    def total_followings 
        self.followings.count 
    end
    def total_friends 
        self.friends.count 
    end
    
    def only_followers
        self.followers - self.followings
    end
    
    def only_followings
        self.followings - self.followers
    end
    
    # グループのメンバーか否か
    def member(group) 
        self.user_to_groups.find_or_create_by(group_id: group.id) 
    end 
    
    def unpermit_member(group) 
        group_to_user = self.group_to_users.find_by(group_id: group.id) 
        group_to_user.destroy if group_to_user
    end 
    
    # 精算の有無についてのメソッド
    def need_pay(pay_record)
        # pay_relationshipがある=支払う必要がある（未精算者）
        self.pay_relationships.find_or_create_by(pay_record_id: pay_record.id) 
    end

    def paied(pay_record)
        pay_relationship = self.pay_relationships.find_by(pay_record_id: pay_record.id) 
        # pay_relationshipを削除=支払う必要なし（精算者）
        pay_relationship.destroy if pay_relationship
    end

    def need_pay?(pay_record) 
        # pay_relationshipがある=支払う必要がある（未精算者）
        self.pay_records.include?(pay_record) 
    end
    
    # 支払いに関わった人についてのメソッド
    def initial_pay(pay_record)
        self.initial_pay_relationships.find_or_create_by(pay_record_id: pay_record.id) 
    end
    
    def join_groups
      self.requested_groups & self.inviting_groups
    end
    
    def only_requested_groups
        self.requested_groups - self.inviting_groups
    end
    
    def only_inviting_groups
        self.inviting_groups - self.requested_groups
    end
    
    
    mount_uploader :image, ImageUploader
end
