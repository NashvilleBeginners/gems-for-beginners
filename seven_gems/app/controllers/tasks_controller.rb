class TasksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource through: :user, shallow: true

  def index
    @q = @tasks.ransack(params[:q])
    @form_options = [@q]
    @form_options.insert(0, @user) if @user
    @tasks = TaskDecorator.decorate_collection(@q.result(distinct: true).paginate(:page => params[:page], per_page: 5))
  end

  def new

  end

  def create
    @user ||= current_user
    @task = @user.tasks.build(task_params)

    if @task.save
      flash[:notice] = "Task created successfully"
      redirect_to user_tasks_path
    else
      flash[:error] = "Task could not be created"
      render 'new'
    end
  end

  def edit
    @task ||= Task.accessible_by(current_ability).find(params[:id])
  end

  def update
    @task ||= Task.accessible_by(current_ability).find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Task updated successfully"
      redirect_to user_tasks_path
    else
      flash[:error] = "Task could not be updated"
      render 'new'
    end
  end

  def complete
    @task = Task.accessible_by(current_ability).find(params[:task_id])
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
