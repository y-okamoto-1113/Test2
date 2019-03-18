# テスト用のadminデータを作成

# 例えばAdminモデルに関しては、テストデータの定義は/spec/factories/users.rbに行います。
# 以下は定義例です。データを生成する毎に通し番号をふってユニークな値を作るようにしています。
FactoryBot.define do
  factory :admin do
    sequence(:name, 10) { |n| "TEST_NAME#{n}"}
    sequence(:email, 10) { |n| "TEST#{n}@example.com"}    # {}内は「do |n| "TEST#{n}@example.com" end」
    sequence(:password, 10) { |n| "password#{n}"}
  end

end