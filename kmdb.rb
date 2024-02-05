# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!

Model.destroy_all

# Generate models and tables, according to the domain model.
# TODO!

# Define the models
class Studio < ActiveRecord::Base
  has_many :movies
end

class Movie < ActiveRecord::Base
  belongs_to :studio
  has_many :roles
  has_many :actors, through: :roles
end

class Actor < ActiveRecord::Base
  has_many :roles
  has_many :movies, through: :roles
end

class Role < ActiveRecord::Base
  belongs_to :movie
  belongs_to :actor
end

# Generate migration files for the models
ActiveRecord::Schema.define do
    create_table :studios do |t|
      t.string :name
    end
  
    create_table :movies do |t|
      t.string :title
      t.integer :year_released
      t.string :rated
      t.belongs_to :studio
    end
  
    create_table :actors do |t|
      t.string :name
    end
  
    create_table :roles do |t|
      t.belongs_to :movie
      t.belongs_to :actor
      t.string :character_name
    end
  end


# Establish the connection to the database
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'your_database_file.db')




# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

Studio.create(name: "Warner Bros.")

Movie.create(title: "Batman Begins", year_released: 2005, rated: "PG-13", studio: Studio.first)
Movie.create(title: "The Dark Knight", year_released: 2008, rated: "PG-13", studio: Studio.first)
Movie.create(title: "The Dark Knight Rises", year_released: 2012, rated: "PG-13", studio: Studio.first)

Actor.create(name: "Christian Bale")
Actor.create(name: "Michael Caine")
Actor.create(name: "Liam Neeson")
Actor.create(name: "Katie Holmes")
Actor.create(name: "Gary Oldman")
Actor.create(name: "Heath Ledger")
Actor.create(name: "Aaron Eckhart")
Actor.create(name: "Maggie Gyllenhaal")
Actor.create(name: "Tom Hardy")
Actor.create(name: "Joseph Gordon-Levitt")
Actor.create(name: "Anne Hathaway")

batman_begins = Movie.find_by(title: "Batman Begins")

Role.create(movie: batman_begins, actor: Actor.find_by(name: "Christian Bale"), character_name: "Bruce Wayne")
Role.create(movie: batman_begins, actor: Actor.find_by(name: "Michael Caine"), character_name: "Alfred")
Role.create(movie: batman_begins, actor: Actor.find_by(name: "Liam Neeson"), character_name: "Ra's Al Ghul")
Role.create(movie: batman_begins, actor: Actor.find_by(name: "Katie Holmes"), character_name: "Rachel Dawes")
Role.create(movie: batman_begins, actor: Actor.find_by(name: "Gary Oldman"), character_name: "Commissioner Gordon")


# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

movies.each do |movie|
    puts movie.title
    movie.roles.each do |role|
      puts "#{role.actor.name} as #{role.character_name}"
    end
    puts ""
  end
  
  # Close the database connection
  db.close