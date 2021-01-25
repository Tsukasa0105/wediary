# frozen_string_literal: true

FactoryBot.define do
  factory :group, class: Group do
    name { 'group' }
    key { 'group' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')) }
  end

  factory :another_group, class: Group do
    name { 'another_group' }
    key { 'another_group' }
  end

  factory :integration_group, class: Group do
    name { 'integration_group' }
    key { 'integration_group' }
  end
end
