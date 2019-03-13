# FactoryBot.define do
#   pass = Faker::Internet.password(8)
#   # FactoryGirlで使うadminのモデルを作ってる。
#   # Fakerを使い、全てのデータを生成してる。
#   # passwordとpassword_confirmationを同じデータにするために、passを定義してそれを代入する形となってる。
#   factory :admin do
#     name                  Faker::Name.name
#     email                 Faker::Internet.email
#     password              pass
#     password_confirmation pass
#   end
# end


# 例えばAdminモデルに関しては、テストデータの定義は/spec/factories/users.rbに行います。
# 以下は定義例です。データを生成する毎に通し番号をふってユニークな値を作るようにしています。
FactoryBot.define do
  factory :admin do
    sequence(:name, 10) { |n| "TEST_NAME#{n}"}
    sequence(:email, 10) { |n| "TEST#{n}@example.com"}    # {}内は「do |n| "TEST#{n}@example.com" end」
    sequence(:password, 10) { |n| "password#{n}"}
  end

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