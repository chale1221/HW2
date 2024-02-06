class AddStudioToMovies < ActiveRecord::Migration[7.1]
  def change
    #Remove line below because of duplication
    #add_reference :movies, :studio, foreign_key: true
  end
end
