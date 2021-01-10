FactoryBot.define do
  factory :group, class: Group do
    name {"group"}
    key {"group"}
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png')) }
  end
  
  factory :another_group, class: Group do
    name {"another_group"}
    key {"another_group"}
  end

end
