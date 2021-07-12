FactoryBot.define do
  factory :event do
    association :user
    title { 'Встреча с генералами КНР и Индии' }
    address { 'Кабул' }
    datetime { DateTime.parse('30.07.2021') }
  end
end
