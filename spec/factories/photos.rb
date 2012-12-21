# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do |f|
    f.title { Faker::Lorem.sentence }
    f.description { Faker::Lorem.paragraph }
  end
end
