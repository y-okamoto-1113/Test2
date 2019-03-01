class AddFamilyRelation23 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :familyRelation2, :string, null: false
    add_column :users, :familyRelationName2, :string, null: false
  end
end
