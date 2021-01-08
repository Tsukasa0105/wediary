FactoryBot.define do
  factory :group, class: Group do
    name {"group"}
    key {"group"}
  end
  
  factory :another_group, class: Group do
    name {"another_group"}
    key {"another_group"}
  end

end
