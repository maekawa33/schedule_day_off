class AddIndexEmailAndLoginTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, [:email, :login_type], unique: true
  end
end
