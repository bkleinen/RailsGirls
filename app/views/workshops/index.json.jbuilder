json.array!(@workshops) do |workshop|
  json.extract! workshop, :name, :date, :description, :venue
  json.url workshop_url(workshop, format: :json)
end