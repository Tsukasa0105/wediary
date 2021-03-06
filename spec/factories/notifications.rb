# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    visiter_id { 1 }
    visited_id { 1 }
    group_id { 1 }
    event_id { 1 }
    action { 'MyString' }
    checked { false }
  end
end
