class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end
  
  def new
    @schedule = current_user.schedules.new
    @schedule.events.new
  end

  def create
    @schedule = current_user.schedules.new(schedule_params)
    if @schedule.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(
      :schedule_title, :assumed_number_people,
      events_attributes: %i[id three_main_events start_time end_time event_title
                            image price store comment _destroy]
    )
  end
end
