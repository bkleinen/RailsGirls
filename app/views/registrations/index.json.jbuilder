json.array!(@registrations) do |registration|
  json.extract! registration, :firstname, :lastname, :email, :twitter, :programming, :railsexperience, :motivation, :os, :specialdiat
  json.url registration_url(registration, format: :json)
end