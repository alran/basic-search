require_relative 'search-query'

document = 'Our luxury loft-style apartments were constructed as condominiums, so your new residence will have: Solid floors and walls (this will be the quietest apartment you\'ve EVER lived in); Premium stainless steel designer appliances; Distinctive accent walls and hardwood flooring; A kitchen that most chefs would drool over with easy to clean gas stove and countertops; Walk in closets with built in storage; Full size washer and dryer in each apartment home. In addition, all residents will enjoy use of our top-notch amenities, including reserved parking, cutting-edge fitness center, wireless internet cafe/business center, and rooftop lounge to soak up the sun!'
query = 'designer kitchen'

puts 'Would you like to test a pre-programmed document and query set? Y/N'
test_run = gets.chomp.downcase

if test_run == 'y'
  puts ''
  puts "We checked the following document for 'designer kitchen':"
  puts ''
  puts document
  puts ''
  puts 'The snippet generated from this search query is:'
  puts ''
  puts generate_snippet(document, query)
else
  puts 'Paste the document test you would like to search'
  document = gets.chomp
  puts ''
  puts 'What is your search query?'
  query = gets.chomp
  puts ''
  puts 'The snippet generated from this search query is:'
  puts ''
  puts generate_snippet(document, query)
end
