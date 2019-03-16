class AddJoinedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :joined, :string
  end
end
