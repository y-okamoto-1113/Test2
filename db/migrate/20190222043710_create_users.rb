class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :furigana
      t.integer :tel
      t.string :mail
      # t.integer :type_sex
      # t.integer :year
      # t.integer :month
      # t.integer :day
      # t.integer :type_career
      
      t.timestamps
    end
  end
end
