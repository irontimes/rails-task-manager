class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
  @task = Task.new

  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    else
      # display the form page again
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # this is for the form builder
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      # display the form page again
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    # status is for turbo
    redirect_to tasks_path, status: :see_other
  end

  private

  # strong params -> white listing the info coming from the form
  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

end
