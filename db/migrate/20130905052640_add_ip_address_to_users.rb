class AddIpAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ip_address, :string, null: false
    add_index :users, :ip_address
  end
end
