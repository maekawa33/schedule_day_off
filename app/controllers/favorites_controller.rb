class FavoritesController < ApplicationController
  def create
    @schedule = Schedule.find(params[:schedule_id])
    @favorite = current_user.favorites.create(schedule_id: params[:schedule_id])
    
  end

  def destroy
    @schedule = Schedule.find(params[:schedule_id])
    @favorite = current_user.favorites.find_by(schedule_id: @schedule.id)
    @favorite.destroy
  end
end
