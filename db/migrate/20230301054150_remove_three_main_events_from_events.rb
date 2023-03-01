class RemoveThreeMainEventsFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :three_main_events, :boolean
  end
end
