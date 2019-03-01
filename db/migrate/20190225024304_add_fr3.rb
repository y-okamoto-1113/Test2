class AddFr3 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :familyRelation3, :string, null: false
    add_column :users, :familyRelationName3, :string, null: false
  end
end
