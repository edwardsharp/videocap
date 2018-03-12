require "roda"
require "tilt/erb"

require "./models/movie"

class VideoRsvp < Roda
  plugin :public

  plugin :render
  plugin :partials

  plugin :assets, js: "app.js", css: "app.css"

  use Rack::MethodOverride
  plugin :all_verbs

  plugin :indifferent_params

  route do |r|
    r.public # serve static assets
    r.assets # serve dynamic assets

    r.root do
      r.redirect "/rsvp"
    end

    r.on "rsvp" do
      # r.get true do
      #   @movies = Movie.all
      #   view("movies/index")
      # end

      r.get true do
        @movie = Movie.new
        view("movies/new")
      end

      r.post true do
        @movie = Movie.create(params[:movie])
        view("movies/thx")
      end



      # r.on Integer do |id|
      #   @movie = Movie[id]

      #   r.get "edit" do
      #     view("movies/edit")
      #   end

      #   r.put do
      #     @movie.update(params[:movie])
      #     r.redirect "/movies"
      #   end

      #   r.delete do
      #     @movie.destroy
      #     r.redirect "/movies"
      #   end
      # end
    end
  end
end
