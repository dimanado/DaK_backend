class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:destroy]

  def destroy
      if @task.delete
        render json: {id: params[:id]}.to_json
      else
        render_error_messages(@task, 400)
      end
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
