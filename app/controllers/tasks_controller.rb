class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv {send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      SampleJob.perform_later
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end
  
  def import 
    begin
      current_user.tasks.import(params[:file])
      # @tasks = current_user.tasks.page(params[:page]).per(10)
      # flash.now[:notice] = "タスクを追加しました"
      redirect_to tasks_url, notice: "タスクを追加しました"
      # render :index
    rescue ActiveRecord::RecordInvalid => e
      # @tasks = current_user.tasks.page(params[:page]).per(10)
      # バリデーションエラーが発生した場合の処理
      # @error_message = e.record.errors.full_messages.join(", ")
      redirect_to tasks_url, alert: "インポート失敗: フォーマットに則したcsvファイルをインポートしてください"
      # flash.now[:alert] = "インポートに失敗しました: #{e.record.errors.full_messages.join(", ")}"
      # render :index
    end
  end
  
  private

  def task_params
    params.require(:task).permit(:name, :description, :image)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
