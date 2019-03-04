class AddColumnToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :mail, :integer, null: false
    add_column :admins, :password, :string, null: false
  end
end
