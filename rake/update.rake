# Gets all of the problems from projecteuler.net and serializes them as yaml
# into the data/problems directory.  This way http requests do not need to be
# each time the manager is asked to describe a problem.

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'colorize'
require 'nokogiri'
require 'open-uri'
require 'reverse_markdown'
require 'yaml'

require 'euler'

desc "Scrape the Project Euler website and download problem descriptions and images"
task :update do

  # Number of seconds to wait in the beginning of each iteration of the http request loop
  sleep_time = 0.5

  puts
  puts 'Updating project Euler problem specs.'
  puts

  data_dir     = "#{__dir__}/../data"
  answers_file = "#{data_dir}/answers.yml"
  problems_dir = "#{data_dir}/problems"
  images_dir   = "#{data_dir}/images"

  puts 'Data directory:     '.light_black + data_dir.underline
  puts 'Answers File:       '.light_black + answers_file.underline
  puts 'Problems Directory: '.light_black + problems_dir.underline
  puts

  problem_ids           = YAML.load_file(answers_file).keys
  problems_count        = problem_ids.count
  problems_count_digits = problems_count.to_s.size

  puts problems_count.to_s.underline + ' Problems will be updated.'
  puts

  # Fetch problems from projecteuler.net
  problems = problem_ids.map.with_index do |problem_id, index|
    zero_padded_index      = (index + 1).to_s.rjust(problems_count_digits, '0')
    zero_padded_problem_id =  problem_id.to_s.rjust(problems_count_digits, '0')

    print "(#{zero_padded_index} / #{problems_count}) ##{zero_padded_index} "

    sleep(sleep_time)

    url = "http://projecteuler.net/problem=#{problem_id}"

    doc = Nokogiri::HTML(open(url))

    problem_name = ReverseMarkdown.convert(doc.css('h2').first.inner_html).strip

    print ": #{problem_name.strip.bold.underline} "

    # download images
    doc.css('.problem_content img').each do |img|
      image_url = "http://projecteuler.net/#{img['src']}"
      file_name = File.basename(image_url)
      file_path = "#{images_dir}/#{file_name}"
      open(image_url) do |i|
        File.open(file_path, 'wb') do |f|
          f.puts(i.read)
        end
      end
      img['src'] = "\{\{\ images_dir\ \}\}/#{file_name}"
    end

    problem = Euler::Problem.new({
      id:       problem_id,
      name:     problem_name,
      url:      url,
      content:  ReverseMarkdown.convert(doc.css('.problem_content').first.to_xml)
    })

    File.open("#{problems_dir}/#{problem.id}.yml", 'w') do |f|
      f.write(problem.to_yaml)
    end

    print "\u2713".encode('utf-8').green.bold
    puts

    problem
  end
end
