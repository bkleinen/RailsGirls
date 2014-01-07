class Settings
  include MongoMapper::Document
  key :logoURL,					String, :default => "railsgirls-logo.png"
  key :frontPageSlogan,			String, :default => "Welcome to Rails Girls"
  key :frontPageDescription,		String, :default =>"You can register for the following workshops:"
end
