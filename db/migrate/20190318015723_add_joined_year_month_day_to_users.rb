class AddJoinedYearMonthDayToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :joined_year, :string
    add_column :users, :joined_month, :string
    add_column :users, :joined_day, :string
  end
end
