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

  def edit
    @event = Event.find(params[:id])
   end

   def update
    @event = Event.find(params[:id])
     if @event.update(event_params)
        redirect_to schedule_path(@event.schedule), notice: "イベント「#{@event.event_title}」を更新しました"
     else
        flash.now[:alert] = "イベントの更新に失敗しました"
        render :edit, status: :unprocessable_entity
     end
   end
 
   def destroy
     @event = Event.find(params[:id])
     @event.destroy
     redirect_to schedule_path(@event.schedule), notice: "イベント「#{@event.event_title}」を削除しました"
   end

  def event_params
    params.require(:event).permit(:start_time, :end_time, :event_title, :image, :price, :store, :comment)
  end
end
