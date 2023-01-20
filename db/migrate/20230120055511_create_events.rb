class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :schedule, null: false, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.string :event_title
      t.string :image
      t.integer :price
      t.string :store
      t.string :comment
      t.boolean :three_main_events

      t.timestamps
    end
  end
end
