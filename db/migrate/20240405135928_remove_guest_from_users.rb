class RemoveGuestFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :guest, :boolean
  end
end
