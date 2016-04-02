class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}
    
    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end
    
    if params[:sort] != session[:sort]
      session[:sort] = sort
      flash.keep
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      flash.keep
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  # def find_with_same_director
  #   @movie = Movie.find(params[:id])
  #   # Find director of current movie
  #   @current_movie_director = @movie.director
  #   if @current_movbvcnie_director.nil? or @current_movie_director.empty?
  #     # If current movie has no director, flash warning and redirect to movies index page
  #     flash[:warning] = "'#{@movie.title}' has no director info."
  #     redirect_to movies_path
  #   else
  #     # Else find all movies with the current movie director
  #     @movies_to_render = Movie.find_all_by_director(@current_movie_director)
  #   end
  # end

  def find_with_same_director
    @movie = Movie.find(params[:id])
    # Find director of current movie
    @current_movie_director = @movie.director
    if @current_movie_director.nil? or @current_movie_director.empty?
      # If current movie has no director, flash warning and redirect to movies index page
      flash[:warning] = "'#{@movie.title}' has no director info."
      redirect_to movies_path
    else
      # Else find all movies with the current movie director
      @movies_to_render = @movie.find_all_by_director
    end
  end
end
