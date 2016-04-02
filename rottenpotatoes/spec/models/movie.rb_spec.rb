require 'simplecov'
SimpleCov.start

require 'rails_helper'


RSpec.describe Movie, :type => :model do
  it "finds all movies by same director" do
  	data1 = Movie.create!(title: "Interstellar", rating: "PG-13", release_date: "2014-11-04", director: "Christopher Nolan")
  	data2 = Movie.create!(title: "The Dark Knight", rating: "PG-13", release_date: "2008-07-18", director: "Christopher Nolan")
  	data3 = Movie.create!(title: "The Dark Knight Rises", rating: "PG-13", release_date: "2012-07-20", director: "Christopher Nolan")
  	data4 = Movie.create!(title: "Titanic", rating: "PG-13", release_date: "1997-12-19", director: "James Cameron")
  	data5 = Movie.create!(title: "Jurassic Park", rating: "PG-13", release_date: "2011-06-11", director: "Steven Spielberg")

  	expect(Movie.find_all_by_director("Christopher Nolan")).to eq([data1, data2, data3])
  end
end

