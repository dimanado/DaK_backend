class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:destroy]

  def destroy
    @task.delete ? render json: {id: params[:id]}.to_json :
        render_error_messages(@task, 400)
  end

  def create
    tasks = Task.create_tasks(params[:id].to_i, tasks_params)
    render json: {tasks: tasks}.to_json
  end

  private

  def tasks_params
    params[:tasks].values
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
