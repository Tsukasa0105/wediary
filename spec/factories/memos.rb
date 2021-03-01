# frozen_string_literal: true

FactoryBot.define do
  factory :memo do
    title { 'Test' }
    content { 'TestText' }
  end
  
  factory :another_memo, class: Memo do
    title { 'another' }
    content { 'another' }
  end
  
  factory :long_title_memo, class: Memo do
    title { 'longlonglonglong' }
    content { 'longlonglonglong' }
  end
  
end
