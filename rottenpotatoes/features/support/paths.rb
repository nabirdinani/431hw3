# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the (RottenPotatoes )?home\s?page$/ then '/movies'
    when /^the movies page$/ then '/movies'

    # Add edit page
    when /^the edit page for "(.*)"$/
      movie_to_edit = Movie.find_by_title($1)
      edit_movie_path(movie_to_edit)

    # Add 'show' page
    when /^the details page for "(.*)"$/
      movie_to_view = Movie.find_by_title($1)
      movie_path(movie_to_view)

    # Add Similar Movies page
    when /^the Similar Movies page for "(.*)"$/
      movie_to_find = Movie.find_by_title($1)
      find_with_same_director_path(movie_to_find)

    when /the new page/
      '/movies/new'

    else
    end
  end
end

World(NavigationHelpers)
