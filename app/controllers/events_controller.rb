class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_schedule, only: [:new, :create, :update]
  def show; end

  def new
    @event = @schedule.events.build
  end

  def edit; end

  def create
    @event = @schedule.events.new(event_params)
    if @event.save
      @events = @schedule.sort_events
    else
      flash.now[:alert] = 'イベントの作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      @events = @schedule.sort_events
    else
      flash.now[:alert] = 'イベントの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to schedule_path(@event.schedule), notice: "イベント「#{@event.event_title}」を削除しました"
  end

  private

  def event_params
    params.require(:event).permit(:start_time, :end_time, :event_title, :image, :price, :store, :comment)
  end

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
