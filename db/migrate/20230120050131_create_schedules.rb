class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.string :schedule_title
      t.integer :assumed_number_people

      t.timestamps
    end
  end
end
