class SchedulesController < ApplicationController
  authorize_resource
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
    @schedules = @q.result(distinct: true).includes(:user).order('created_at desc').page(params[:page]).per(20)
  end

  def show
    @schedule = Schedule.find(params[:id])
    @user = @schedule.user
    @events = @schedule.sort_events
  end

  def new
    @schedule = current_user.schedules.new
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = current_user.schedules.new(schedule_params)
    if @schedule.save
      redirect_to schedule_path(@schedule), notice: "スケジュール「#{@schedule.schedule_title}」を作成しました"
    else
      flash.now[:alert] = 'スケジュールの作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to schedule_path(@schedule), notice: "スケジュール「#{@schedule.schedule_title}」を更新しました"
    else
      flash.now[:alert] = 'スケジュールの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to schedules_path, notice: "スケジュール「#{@schedule.schedule_title}」を削除しました"
  end

  def rank
    @month_schedule_favorite_ranks = Schedule.find(Favorite.group(:schedule_id).where(created_at: Time.current.all_month).order('count(schedule_id) desc').pluck(:schedule_id))
  end

  private

  def schedule_params
    params.require(:schedule).permit(:schedule_title, :assumed_number_people, :get_up_time, :sleep_time)
  end
end
