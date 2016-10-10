require_relative '../../lib/euler.rb'

one_to_one_thousand = (1...1000).to_a

divisible_by_three_or_five = lambda { |num|
  num % 3 == 0 || num % 5 == 0
}

answer = one_to_one_thousand.select(&divisible_by_three_or_five).reduce(:+)

puts answer
