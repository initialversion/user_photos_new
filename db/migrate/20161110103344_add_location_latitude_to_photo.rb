class AddLocationLatitudeToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :location_latitude, :float
  end
end
