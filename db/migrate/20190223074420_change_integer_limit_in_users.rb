class ChangeIntegerLimitInUsers < ActiveRecord::Migration[5.2]
  def change
    # integer型はデフォルトで４バイト。電話番号は数字の桁としてかなり大きい為、８バイトに設定しなあかん。
    # scheme.rbでは、８バイトのinteger型であることを意味する「bigint」で書かれている。
    change_column :users, :tel, :integer, limit: 8
  end
end
