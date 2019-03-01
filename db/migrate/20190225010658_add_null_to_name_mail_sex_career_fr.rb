class AddNullToNameMailSexCareerFr < ActiveRecord::Migration[5.2]
  def change
    # null: false を追加。
    change_column_null :users, :name, false
    change_column_null :users, :mail, false
    change_column_null :users, :type_sex, false
    change_column_null :users, :type_career, false
    change_column_null :users, :familyRelation, false
    change_column_null :users, :familyRelationName, false
  end
end
