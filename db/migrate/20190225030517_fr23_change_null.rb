class Fr23ChangeNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :familyRelation2, true
    change_column_null :users, :familyRelationName2, true
    change_column_null :users, :familyRelation3, true
    change_column_null :users, :familyRelationName3, true

  end
end
