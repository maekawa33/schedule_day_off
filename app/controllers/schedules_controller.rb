class SchedulesController < ApplicationController
  authorize_resource
  def index
    @q = Schedule.ransack(params[:q])
    @schedules = @q.result(distinct: true).includes(:user).order('created_at desc').page(params[:page]).per(20)
  end

  def show
    @schedule = Schedule.find(params[:id])
    @user = @schedule.user
  end

  def new
    @schedule = current_user.schedules.new
    @schedule.events.new
  end

  def create
    @schedule = current_user.schedules.new(schedule_params)
    if @schedule.save
      redirect_to schedules_path, notice: "スケジュール「#{@schedule.schedule_title}」を投稿しました"
    else
      flash.now[:alert] = "スケジュールの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
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

  private

  def schedule_params
    params.require(:schedule).permit(
      :schedule_title, :assumed_number_people, :get_up_time, :sleep_time,
      events_attributes: %i[id three_main_events start_time end_time event_title
                            image price store comment _destroy]
    )
  end
end
