class SchedulesController < ApplicationController
  authorize_resource
  before_action :set_schedule, only: %i[show edit update destroy]
  def index
    @q = Schedule.ransack(params[:q])
    @schedules = @q.result(distinct: true).includes(%i[user schedule_tags
                                                       events]).order('created_at desc').page(params[:page]).per(20)
  end

  def show
    @user = @schedule.user
    @events = @schedule.sort_events
  end

  def new
    @schedule = current_user.schedules.build
  end

  def edit; end

  def create
    @schedule = current_user.schedules.new(schedule_params)
    if @schedule.save_with_tags(tag_names)
      redirect_to schedule_path(@schedule), success: t('.success', title: @schedule.schedule_title)
    else
      flash.now[:error] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @schedule.assign_attributes(schedule_params)
    if @schedule.save_with_tags(tag_names)
      redirect_to schedule_path(@schedule), success: t('.success', title: @schedule.schedule_title)
    else
      flash.now[:error] = t('.fail', title: @schedule.schedule_title)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_path, success: t('.success', title: @schedule.schedule_title)
  end

  def rank
    favorite_schedule_ids = Favorite.month_schedules.count_desc.pluck(:schedule_id)
    @month_schedule_favorite_ranks = Schedule.includes(%i[user events]).find(favorite_schedule_ids)
  end

  private

  def schedule_params
    params.require(:schedule).permit(:schedule_title, :assumed_number_people, :get_up_time, :sleep_time)
  end

  def tag_names
    params[:schedule][:tag_names].split(/[[:blank:]]+/).uniq
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end
end
