class TasksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Task created successfully"
      redirect_to tasks_path
    else
      flash[:error] = "Task could not be created"
      redirect_to tasks_path
    end
  end

  def edit
  end

  def update
  end

  def complete
  end

  private

  def task_params
    params.require(:task).permit(:description, :category_id, :complete)
  end
end
