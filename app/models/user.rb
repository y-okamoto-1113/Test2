class User < ApplicationRecord


  validates :name, presence: true # ,length:{minimum: 2}
  validates :tel, presence: true, uniqueness: true, format:{with: (/0[5789]0[\d{8}]+$/), multiline: true } #ハイフンはcreateアクションで削除してる。 最後に「+$」を付けないと「09012345678」のように記述できてたら後ろに何つけてもエラーなく通ってしまう。
  validates :mail, presence: true, uniqueness: true, format:{with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i } #format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :type_sex, presence: true ,format:{with: /\A(男|女)\z/ }  #「男」、「女」の一文字しか入らへんようにしてる
  validates :type_career, presence: true,format:{with: /\A(大卒|高卒|中卒|学歴無し)\z/ }  #大卒、高卒、中卒、学歴無ししか入らへんようにしてる。
  validates :school_name, presence: true
  validates :familyRelation, {presence: true}
  validates :familyRelationName, {presence: true}
  validates :position, presence: true
  validates :joined_year, presence: true
  validates :joined_month, presence: true
  validates :joined_day, presence: true
  # year, month, day も選択式やから大丈夫やけど、コンソールからやと格納できるデータは自由やから制限かけたい

end
