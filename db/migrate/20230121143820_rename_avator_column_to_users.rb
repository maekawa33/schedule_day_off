class RenameAvatorColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :avator, :avatar
  end
end
