namespace :movies do
  desc "Clear out database and import movies."
  task import: :environment do

    logger.info "Cleaning up..."
    destroy_all_records
    logger.info "Records cleaned up!"

    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil

    @actors  = create_actors
    @writers = create_writers

    logger.info "Parsing movie data..."
    movies = YAML.load_file(
      File.join(Rails.root, 'movies.yml')
    ).map(&:with_indifferent_access)

    logger.info "Creating Movies: #{movies.count} movies total."

    movies.each do |movie|
      Movie.create(
        title:   movie[:title],
        year:    movie[:year],
        studio:  Studio.find_or_create_by(name: movie[:studio]),
        genre:   Genre.find_or_create_by(name:  movie[:genre]),
        price:   rand(100),
        actors:  assignable_actors,
        writers: assignable_writers
      )
      print "."
    end

    logger.info "Created #{Movie.count} movies total."

    ActiveRecord::Base.logger = old_logger
  end

  private

    def destroy_all_records
      [Movie, Genre, Studio].each(&:destroy_all)
    end

    def create_actors
      142.times.map { Actor.create(name: Faker::Name.name) }
    end

    def create_writers
      123.times.map { Writer.create(name: Faker::Name.name) }
    end

    def assignable_actors
      rand(1..7).times.map { @actors.sample }.uniq
    end

    def assignable_writers
      rand(1..3).times.map { @writers.sample }.uniq
    end

    def logger
      Rails.logger
    end

end
