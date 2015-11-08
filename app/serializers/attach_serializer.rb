class AttachSerializer < ActiveModel::Serializer
  attributes :url, :name

  def url
    object.filename.url
  end

  def name
    object.filename_identifier
  end
end
