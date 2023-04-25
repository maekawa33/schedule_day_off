class TriesController < ApplicationController
  def create
    @schedule = Schedule.find(params[:schedule_id])
    @try = current_user.tries.create(schedule_id: params[:schedule_id])
  end

  def destroy
    @schedule = Schedule.find(params[:schedule_id])
    @try = current_user.tries.find_by(schedule_id: @schedule.id)
    @try.destroy
  end
end
