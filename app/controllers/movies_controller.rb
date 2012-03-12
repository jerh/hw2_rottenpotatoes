class MoviesController < ApplicationController

  SORTABLE_COLUMN = ['title', 'release_date']

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    setup_ratings
    if SORTABLE_COLUMN.include? params[:sort]
      sort_column = params[:sort]
    else
      sort_column = 'title'
    end

    if params[:ratings] #user filter
      @movies = Movie.where(:rating => params[:ratings].keys).order sort_column
    else
      @movies = Movie.order sort_column
    end
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

  def setup_ratings
    ratings = Movie.all_ratings
    @all_ratings = {}
    ratings.each do |rating|
      @all_ratings[rating] = params[:ratings]? params[:ratings][rating] : nil
    end
  end

end
