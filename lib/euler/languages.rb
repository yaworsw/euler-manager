# Loads the default language definitions using a white list.
[

  'ruby'

].each do |lang|
  require_relative "./languages/#{lang}"
end
