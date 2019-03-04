class RemoveColumnFromAdmins < ActiveRecord::Migration[5.2]
  def change
    remove_column :admins, :mail
    remove_column :admins, :password
  end
end
