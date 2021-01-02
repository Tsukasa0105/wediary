FactoryBot.define do
  factory :user, class: User do
    name {"user"}
    email {"user@gmail.com"}
    password {"0000000"}
    password_confirmation {"0000000"}
  end

  factory :another_user, class: User do
    name {"another_user"}
    email {"anotheruser@gmail.com"}
    password {"0000000"}
    password_confirmation {"0000000"}
  end

  factory :short_password_user, class: User do
    name {"short_password_user"}
    email {"shortpassworduser@gmail.com"}
    password {"short"}
    password_confirmation {"short"}
  end

  factory :password_unmatch_user, class: User do
    name {"password_unmatch_user"}
    email {"passwordunmatchuser@gmail.com"}
    password {"password1"}
    password_confirmation {"password2"}
  end
  

end
