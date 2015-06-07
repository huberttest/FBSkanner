class AddToWroclawPokojeWynajem < ActiveRecord::Migration
  def change
    add_column :wroclaw_pokoje_wynajems, :userphoto, :string
    add_column :wroclaw_pokoje_wynajems, :username, :string
    add_column :wroclaw_pokoje_wynajems, :adsphoto, :string
    add_column :wroclaw_pokoje_wynajems, :description1, :string
    add_column :wroclaw_pokoje_wynajems, :description2, :string
    add_column :wroclaw_pokoje_wynajems, :price, :integer
    add_column :wroclaw_pokoje_wynajems, :localization, :string
    add_column :wroclaw_pokoje_wynajems, :whenavailable, :string
    add_column :wroclaw_pokoje_wynajems, :howmanypeopleinroom, :integer
    add_column :wroclaw_pokoje_wynajems, :linktooffer, :string
  end
end
