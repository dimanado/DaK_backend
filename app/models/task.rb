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

  def self.parsing_to_array(items)
    tasks = []
    items.each do |item_name|
      tasks << Task.find_by(name: item_name)
    end
    tasks
  end
end
