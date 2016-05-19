class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @tasks = TasksDecorator.decorate_collection(Task.paginate(:page => params[:page], per_page: 5))
  end

  def new
    @user = current_user
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:notice] = "Task created successfully"
      redirect_to user_tasks_path
    else
      flash[:error] = "Task could not be created"
      redirect_to :back
    end
  end

  def edit
    @user = current_user
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

  end

  def complete
    @task = Task.find(params[:task_id])
    @task.complete = true
    if @task.save
      flash[:notice] = "Task completed."
      redirect_to user_tasks_path
    else
      flash[:error] = "Task couldn't be completed."
      redirect_to :back
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :category_id, :complete)
  end
end
