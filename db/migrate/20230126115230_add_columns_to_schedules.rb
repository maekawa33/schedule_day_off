class AddColumnsToSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :schedules, :get_up_time, :time, null: false
    add_column :schedules, :sleep_time, :time, null: false
  end
end
