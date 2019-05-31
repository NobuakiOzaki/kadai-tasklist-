class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]
  before_action :require_user_logged_in
  # before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:destroy]
  
  def index
   @tasks = Task.all.order(id: :desc).page(params[:page]).per(6)
  end
  
  def show
  end
  
  def new
   @task = Task.new
  end
  
  
  def create
  # @task = Task.new(task_params)
   @task = current_user.tasks.build(task_params)
   if @task.save
     flash[:success] = "タスクリストに正常に追記されました"
    # redirect_to @task
    redirect_to root_url
   else
     @tasks = current_user.tasks.order(id: :desc).page(params[:page])
     flash.now[:danger] = "タスクリストに追記できませんでした"
    # render :new
     render 'toppages/index'
   end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "タスクリストは正常に変更されました"
      redirect_to root_url
    else
     flash.now[:danger] = "タスクリストは変更されませんでした"
     render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクリストは正常に削除されました"
    # redirect_to tasks_url
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
