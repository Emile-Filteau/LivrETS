json.array!(@programs) do |program|
  json.extract! program, :id, :name, :acronym, :color
end
