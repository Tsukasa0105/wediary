# frozen_string_literal: true

class PayRecord < ApplicationRecord
  has_many :pay_relationships, dependent: :destroy
  has_many :users, through: :pay_relationships
  has_many :initial_pay_relationships, foreign_key: 'pay_record_id', dependent: :destroy
  has_many :initial_users, through: :initial_pay_relationships, source: :initial_user
  belongs_to :event

  validates :name, presence: true
  validates :amount, presence: true
end
