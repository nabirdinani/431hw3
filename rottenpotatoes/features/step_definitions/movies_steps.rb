Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(:title => movie['title'], :rating => movie['rating'], :release_date => movie['release_date'], :director => movie['director'])
  end
end

Then (/^the director of "(.*)" should be "(.*)"$/) do |movie, dir|
  assert (Movie.find_by_title(movie).director == dir)
end