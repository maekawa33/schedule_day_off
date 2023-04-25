class CreateTries < ActiveRecord::Migration[7.0]
  def change
    create_table :tries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
