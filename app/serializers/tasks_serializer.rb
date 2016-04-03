class TasksSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :format
  def url
    object.full_url
  end
end