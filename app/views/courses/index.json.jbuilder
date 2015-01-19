json.array!(@courses) do |course|
  json.extract! course, :id, :name, :acronym, :program_id
end
