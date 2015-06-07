class CreateWroclawPokojeWynajems < ActiveRecord::Migration
  def change
    create_table :wroclaw_pokoje_wynajems do |t|

      t.timestamps null: false
    end
  end
end
