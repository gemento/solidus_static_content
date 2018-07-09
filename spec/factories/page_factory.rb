FactoryBot.define do
  factory :page, class: Spree::Page do
    title { FFaker::Book.title }
    body  { FFaker::Book.description }

    sequence(:slug) { |n| "/page#{n}" }

    trait :with_foreign_link do
      foreign_link { FFaker::Internet.http_url }
    end
  end
end
