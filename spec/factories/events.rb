# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'event' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')) }
    start_time { DateTime.now }
  end
end
