class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(schedule_id: params[:schedule_id])
    redirect_to request.referer
    
  end

  def destroy
    @schedule = Schedule.find(params[:schedule_id])
    @favorite = current_user.favorites.find_by(schedule_id: @schedule.id)
    @favorite.destroy
    redirect_to request.referer,status: :see_other
  end
end
