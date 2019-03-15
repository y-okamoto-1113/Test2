FactoryBot.define do
  factory :user do
    sequence(:name, 9) { |n| "USER_NAME#{n}"}
    sequence(:tel, 9) { |n| "0701111111#{n}"}
    sequence(:mail, 9) { |n| "USER#{n}@example.com"}
    sequence(:type_sex, 9) { |n| "男"}
    sequence(:type_career, 9) { |n| "学歴無し"}
    sequence(:school_name, 9) { |n| "学歴無し"}
    sequence(:familyRelation, 9) { |n| "father#{n}"}
    sequence(:familyRelationName, 9) { |n| "taro#{n}"}
  end
end