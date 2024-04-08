class RenameAdressLineToAddressLine < ActiveRecord::Migration[7.1]
  def change
    rename_column :addresses, :adress_line, :address_line
  end
end
