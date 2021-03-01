# frozen_string_literal: true

FactoryBot.define do
  factory :map do
    latitude { 35.681 }
    longitude { 139.767 }
    title { 'map' }
  end
  
  factory :another_map, class: Map do
    latitude { 40.000 }
    longitude { 130.000 }
    title { 'another_map' }
  end
end
