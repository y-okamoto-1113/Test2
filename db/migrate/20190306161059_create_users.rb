class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string :name
      t.string :furigana
      t.string :tel
      t.string :mail, null: false
      t.string :type_sex, null: false
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :type_career, null: false
      t.string :school_name
      t.string :familyRelation, null: false
      t.string :familyRelationName, null: false
      t.string :familyRelation2
      t.string :familyRelationName2
      t.string :familyRelation3
      t.string :familyRelationName3

      t.timestamps
    end
  end
end
