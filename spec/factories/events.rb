FactoryBot.define do
  factory :event do
    name {"event"}
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')) }
  end
end
