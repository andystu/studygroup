json.array!(@groups) do |group|
  json.extract! group, :id, :title, :description, :user_id, :limitation
  json.url group_url(group, format: :json)
end
