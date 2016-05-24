class CourseForm
  include Virtus.model

  attribute :name, String
  attribute :description, String
  attribute :image, Hash
  attribute :tasks, Hash
  attribute :category_ids, Hash

  def save(id)
    course = Course.new(name: name, description:description, category_ids:
        category_ids.values, tasks: Task.parsing_to_array(tasks.values), user_id: id )
    course.build_image(file: image.tempfile)
    course.save
  end
end