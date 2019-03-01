class ChangeDataTypeOfCareer < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :type_career, :string
  end
end
