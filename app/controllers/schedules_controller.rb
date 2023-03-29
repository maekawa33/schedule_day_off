class SchedulesController < ApplicationController
  authorize_resource
  before_action :set_schedule, only: %i[show edit update destroy]
  def index
    fix_params = params[:q]
    if fix_params
      if fix_params['get_up_time_gteq(4i)'].blank? || fix_params['get_up_time_gteq(5i)'].blank?
        fix_params['get_up_time_gteq(1i)'], fix_params['get_up_time_gteq(2i)'], fix_params['get_up_time_gteq(3i)'] = nil
      end
      if fix_params['get_up_time_lteq(4i)'].blank? || fix_params['get_up_time_lteq(5i)'].blank?
        fix_params['get_up_time_lteq(1i)'], fix_params['get_up_time_lteq(2i)'], fix_params['get_up_time_lteq(3i)'] = nil
      end
      if fix_params['sleep_time_gteq(4i)'].blank? || fix_params['sleep_time_gteq(5i)'].blank?
        fix_params['sleep_time_gteq(1i)'], fix_params['sleep_time_gteq(2i)'], fix_params['sleep_time_gteq(3i)'] = nil
      end
      if fix_params['sleep_time_lteq(4i)'].blank? || fix_params['sleep_time_lteq(5i)'].blank?
        fix_params['sleep_time_lteq(1i)'], fix_params['sleep_time_lteq(2i)'], fix_params['sleep_time_lteq(3i)'] = nil
      end
      @q = Schedule.ransack(fix_params)
    else
      @q = Schedule.ransack(params[:q])
    end
    @schedules = @q.result(distinct: true).includes(%i[user
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
    if @schedule.save
      redirect_to schedule_path(@schedule), success: t('.success', title: @schedule.schedule_title)
    else
      flash.now[:error] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @schedule.update(schedule_params)
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
    favorite_schedule_ids = Favorite.where(created_at: Time.current.all_month).group(:schedule_id).order('count(schedule_id) desc').pluck(:schedule_id)
    @month_schedule_favorite_ranks = Schedule.includes(%i[user events]).find(favorite_schedule_ids)
  end

  private

  def schedule_params
    params.require(:schedule).permit(:schedule_title, :assumed_number_people, :get_up_time, :sleep_time)
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end
end
