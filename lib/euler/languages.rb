# Loads the default language definitions using a white list.
[

  'coffeescript',
  'javascript',
  'python',
  'ruby',
  'scala',
  'java'

].each do |lang|
  require_relative "./languages/#{lang}"
end
