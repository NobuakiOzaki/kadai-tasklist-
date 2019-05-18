class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
   @tasks = Task.all
  end
  
  def show
  end
  
  def new
   @task = Task.new
  end
  
  def create
   @task = Task.new(task_params)
   
   if @task.save
     flash[:success] = "項目が正常に追加されました"
     redirect_to @task
   else
     flash.now[:danger] = "項目が追加できませんでした"
     render :new
   end
  end
  
  def edit
  end
  
  def update
   if @task.update(task_params)
     flash[:success] = "項目は正常に変更されました"
      redirect_to @task
   else
     flash.now[:danger] = "項目は変更されませんでした"
     render :edit
   end
  end
  
  def destroy
   @task.destroy
  
   flash[:success] = "項目は正常に削除されました"
   redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content)
  end
end
