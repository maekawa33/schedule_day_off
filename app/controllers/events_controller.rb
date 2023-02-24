class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
  end

  def new
    @schedule = Schedule.find(params[:schedule_id])
    @event = @schedule.events.build
  end

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @event = @schedule.events.new(event_params)

    if @event.save
      @events = @schedule.events.order(:start_time)
    else
      flash.now[:alert] = "イベントの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def delete
  end

 
   def update
    @schedule = Schedule.find(params[:id])
     if @schedule.update(schedule_params)
        redirect_to schedules_path, notice: "スケジュール「#{@schedule.schedule_title}」を更新しました"
     else
        flash.now[:alert] = "スケジュールの更新に失敗しました"
        render :new, status: :unprocessable_entity
     end
   end
 
   def destroy
     @schedule = Schedule.find(params[:id])
     @schedule.destroy
     redirect_to schedules_path, notice: "スケジュール「#{@schedule.schedule_title}」を削除しました"
   end

  def event_params
    params.require(:event).permit(:start_time, :end_time, :event_title, :image, :price, :store, :comment)
  end
end
