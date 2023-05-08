class RemoveFavoritesCountFromSchedules < ActiveRecord::Migration[7.0]
  def change
    remove_column :schedules, :favorites_count, :integer
  end
end
