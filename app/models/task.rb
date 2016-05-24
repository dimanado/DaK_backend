class Task < ActiveRecord::Base
  belongs_to :course
  mount_uploader :file, TaskUploader

  def self.create_tasks(id, items)
    course = Course.find(id)
    tasks = []
    items.each do |task|
      tasks << Task.create(name: task.original_filename.rpartition('.').first, file: task.tempfile, format:
          task.original_filename.rpartition('.').last)
    end
    course.tasks.push(*tasks)
    tasks
  end
end
