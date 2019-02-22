class CreateUsers < ActiveRecord::Migration[5.2]
  # ここはテーブルを作る関数。だからカラムを追加したかったら、「https://qiita.com/azusanakano/items/a2847e4e582b9a627e3a」
  def change
    create_table :users do |t|
      t.string :name
      t.string :furigana
      t.integer :tel
      t.string :mail
      t.integer :type_sex
      t.integer :year
      t.integer :month
      t.integer :day
      t.integer :type_career
      
      t.timestamps
    end
  end
end
