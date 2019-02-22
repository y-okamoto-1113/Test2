class AddColumnToUsers < ActiveRecord::Migration[5.2]
  # 「https://qiita.com/azusanakano/items/a2847e4e582b9a627e3a」
  def change
    add_column :users, :familyRelation, :string
    add_column :users, :familyRelationName, :string
  end
end
