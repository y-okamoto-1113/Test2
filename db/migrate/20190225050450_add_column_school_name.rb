class AddColumnSchoolName < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :school_name, :string, after: :type_career
  end
end
