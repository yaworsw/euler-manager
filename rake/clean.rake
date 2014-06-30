# Delete all of the problem's .yaml files and the images from the data directory

desc "Deletes all of the data that has been downloaded for Project Euler problems"
task :clean do

  data_dir     = "#{__dir__}/../.data"
  answers_file = "#{data_dir}/answers.yml"
  problems_dir = "#{data_dir}/problems"
  images_dir   = "#{data_dir}/images"

  FileUtils.rm_rf(images_dir)
  FileUtils.rm_rf(problems_dir)

  FileUtils.mkdir(images_dir)
  FileUtils.mkdir(problems_dir)
end
