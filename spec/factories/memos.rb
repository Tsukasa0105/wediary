# frozen_string_literal: true

FactoryBot.define do
  factory :memo do
    title { 'Test' }
    content { 'TestText' }
  end
end
