class RemoveStoreFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :store, :string
  end
end
