class ChangeDataTypeOfTel < ActiveRecord::Migration[5.2]
  def change
    # データ型変更。 integer型やと「０９０」の最初のゼロが削除されるから、string型
    change_column :users, :tel, :string
  end
end
