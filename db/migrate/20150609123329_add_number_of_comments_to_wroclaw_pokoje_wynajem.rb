class AddNumberOfCommentsToWroclawPokojeWynajem < ActiveRecord::Migration
  def change
  	add_column :wroclaw_pokoje_wynajems, :number_of_comments, :string
  end
end
