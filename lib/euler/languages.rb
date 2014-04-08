# Loads the default language definitions using a white list.
[

  'ruby',
  'scala'

].each do |lang|
  require_relative "./languages/#{lang}"
end
