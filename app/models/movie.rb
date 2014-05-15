class Movie < ActiveRecord::Base
  belongs_to :year
  belongs_to :genre
  belongs_to :studio

  def self.import
    Rails.logger.info "Cleaning up.."

    Movie.delete_all
    Genre.delete_all
    Year.delete_all
    Studio.delete_all

    Rails.logger.info "parsing data.."
    f = File.join(Rails.root, 'movies.yml')
    movies = YAML.load_file(f)
    genres_m = movies.group_by {|m| m[:genre]}
    years_m = movies.group_by {|m| m[:year]}
    studios_m = movies.group_by {|m| m[:studio]}

    genres = {}
    studios = {}
    years = {}

    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil

    Rails.logger.info "Creating Genres.."
    genres_m.keys.each {|g| genres[g] = Genre.create(name: g);}
    Rails.logger.info "Creating Studios.."
    studios_m.keys.each {|s| studios[s] = Studio.create(name: s)}
    Rails.logger.info "Creating Years.."
    years_m.keys.each {|y| years[y] = Year.create(year: y.to_i)}

    total = movies.length
    Rails.logger.info "Creating Movies: #{total} movies total."
    movies.each_with_index do |m,i|
      Movie.create(
        title: m[:title],
        year: years[m[:year]],
        studio: studios[m[:studio]],
        genre: genres[m[:genre]]
      )

    end
    ActiveRecord::Base.logger = old_logger
  end
end
