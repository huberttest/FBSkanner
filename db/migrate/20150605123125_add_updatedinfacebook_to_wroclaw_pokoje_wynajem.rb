class AddUpdatedinfacebookToWroclawPokojeWynajem < ActiveRecord::Migration
  def change
  	add_column :wroclaw_pokoje_wynajems, :updatedinfacebok, :string
  end
end
