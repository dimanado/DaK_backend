class Task < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :course
  mount_uploader :file, TaskUploader

  def self.parsing_to_array(items)
    tasks = []
    items.each do |task|
      tasks << Task.create(name: task.original_filename.rpartition('.').first, file: task.tempfile, format:
          task.original_filename.rpartition('.').last)
    end
    tasks
  end
end
