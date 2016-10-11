require 'digest/sha1'
require 'yaml'

desc "SHA problem solutions"
task :sha_answers do

  data_dir         = "#{__dir__}/../data"
  answers_file     = "#{data_dir}/answers.yml"
  raw_answers_file = "#{data_dir}/answers-raw.yml"

  raw_answers = YAML.load_file(answers_file)

  raw_answers.map do |id, answer|
    Digest::SHA1.hexdigest(answer)
  end

  File.open(answers_file, 'w') do |f|
    f.write(raw_answers.to_yaml)
  end
end
