class AddPlaceIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :place_id, :integer
    add_index :posts, :place_id
  end
end
