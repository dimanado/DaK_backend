json.courses do
  json.array! @courses, :id, :name
end
