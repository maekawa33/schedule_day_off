class AddFavoritesCountToSchedules < ActiveRecord::Migration[7.0]
  def self.up
    add_column :schedules, :favorites_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :schedules, :favorites_count
  end
end
