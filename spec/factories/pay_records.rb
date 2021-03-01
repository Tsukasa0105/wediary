# frozen_string_literal: true

FactoryBot.define do
  factory :pay_record do
    name { 'pay_record' }
    amount { 1000 }
  end
  
  factory :another_pay_record, class: PayRecord do
    name { 'another_pay_record' }
    amount { 1000 }
  end
end
