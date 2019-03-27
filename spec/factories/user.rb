# テスト用のユーザーデータを作成
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
    sequence(:position, 9) { |n| "heehaa#{n}" }
    sequence(:joined_year, 9) { |n| "199#{n}" }
    sequence(:joined_month, 9) { |n| "#{n}" }
    sequence(:joined_day, 9) { |n| "1#{n}" }

  end
end