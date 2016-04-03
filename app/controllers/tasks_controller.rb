class TasksController < ApplicationController
  before_action :authenticate_user!

  def destroy
    task = Task.find(params[:id])
    if task.delete
      render json: {id: params[:id]}.to_json
    else
      render_error_messages(task, 400)
    end
  end

  def create
    course = Course.find(params[:id].to_i)
    Task.parsing_to_array(tasks_params).each do |task|
      course.tasks << task
    end
    render json: {tasks: course.tasks}.to_json
  end

  private

  def tasks_params
    params[:tasks].values
  end

end
