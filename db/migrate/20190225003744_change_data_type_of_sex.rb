class ChangeDataTypeOfSex < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :type_sex, :string
  end
end
