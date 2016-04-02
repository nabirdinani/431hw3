require 'simplecov'
SimpleCov.start

require 'rails_helper'

RSpec.describe MoviesController, :type => :controller do

	# (title: "Interstellar", rating: "PG-13", release_date: "2014-11-04", director: "Christopher Nolan")
	# (title: "The Dark Knight", rating: "PG-13", release_date: "2008-07-18", director: "Christopher Nolan")
	# (title: "The Dark Knight Rises", rating: "PG-13", release_date: "2012-07-20", director: "Christopher Nolan")
	# (title: "Titanic", rating: "PG-13", release_date: "1997-12-19", director: "James Cameron")
	# (title: "Jurassic Park", rating: "PG-13", release_date: "2011-06-11", director: "Steven Spielberg")

	it "testing update method" do
		post :create, movie: {title: "Jurassic Park", rating: "PG-13", release_date: "2011-06-11", director: "Steven Spielberg"}
		get :update, {:id => 1}
		expect(response.response_code).to be(302)
	end

	it "testing edit method" do
		post :create, movie: {title: "Titanic", rating: "PG-13", release_date: "1997-12-19", director: "James Cameron"}
		get :edit, {:id => 1}
		expect(response).to render_template :edit, {:id => 1}
		expect(Movie.count).to eq(1)
	end

	it "testing destroy method" do
		post :create, movie: {title: "Titanic", rating: "PG-13", release_date: "1997-12-19", director: "James Cameron"}
		expect(Movie.count).to eq(1)
		get :destroy, {:id => 1}
		expect(Movie.count).to eq(0)
	end

	it "testing index method" do
		post :create, movie: {title: "Jurassic Park", rating: "PG-13", release_date: "2011-06-11", director: "Steven Spielberg"}
		post :create, movie: {title: "The Dark Knight", rating: "PG-13", release_date: "2008-07-18", director: "Christopher Nolan"}
		post :create, movie: {title: "The Dark Knight Rises", rating: "PG-13", release_date: "2012-07-20", director: "Christopher Nolan"}
		post :create, movie: {title: "Titanic", rating: "PG-13", release_date: "1997-12-19", director: "James Cameron"}
		post :create, movie: {title: "Interstellar", rating: "PG-13", release_date: "2014-11-04", director: "Christopher Nolan"}
		get :index
		expect(response).to render_template :index

		expect(Movie.count).to eq(5)
	end

	it "movies with same director" do
		post :create, movie: {title: "The Dark Knight", rating: "PG-13", release_date: "2008-07-18", director: "Christopher Nolan"}
		post :create, movie: {title: "The Dark Knight Rises", rating: "PG-13", release_date: "2012-07-20", director: "Christopher Nolan"}

		expect(Movie.count).to eq(2)
		get :find_with_same_director, {:id => 1}
		expect(response.response_code).to be(200)
	end

	it "show movies" do
		post :create, movie: {title: "The Dark Knight", rating: "PG-13", release_date: "2008-07-18", director: "Christopher Nolan"}
		post :create, movie: {title: "The Dark Knight Rises", rating: "PG-13", release_date: "2012-07-20", director: "Christopher Nolan"}

		expect(Movie.count).to eq(2)
		get :show, {:id => 1}
		expect(response.response_code).to be(200)
	end

	it "testing similar movies route" do
		post :create, movie: {title: "The Dark Knight", rating: "PG-13", release_date: "2008-07-18", director: "Christopher Nolan"}
		post :create, movie: {title: "The Dark Knight Rises", rating: "PG-13", release_date: "2012-07-20", director: "Christopher Nolan"}

		expect(Movie.count).to eq(2)
		
		expect(:get =>  "movies/get_movies_with_same_director/:id").to route_to(:controller => "movies",
        :action => "find_with_same_director", :id => ":id")
	end
end






