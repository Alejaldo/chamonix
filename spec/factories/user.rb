FactoryBot.define do
  factory :user do
    name { "Mr. Acribald@#{rand(99)}" }

    sequence :email do |n|
      "person#{n}@example.com"
    end

    after(:build) { |user| user.password_confirmation = user.password = "123456"}
  end
end
