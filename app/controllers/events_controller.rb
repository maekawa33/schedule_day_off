class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :set_schedule, only: %i[new create update reference]
  def show; end

  def reference
    @events = Event.all.order('RANDOM()').page(params[:page]).without_count.per(5)
  end

  def new
    @event = @schedule.events.build
    @reference_event_title = params[:title]
  end

  def edit; end

  def create
    @event = @schedule.events.new(event_params)
    if @event.save
      @events = @schedule.sort_events
    else
      @reference_event_title = event_params[:event_title]
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      @events = @schedule.sort_events
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to schedule_path(@event.schedule)
  end

  private

  def event_params
    params.require(:event).permit(:start_time, :end_time, :event_title, :image, :price, :comment)
  end

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
