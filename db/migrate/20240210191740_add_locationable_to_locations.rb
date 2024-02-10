class AddLocationableToLocations < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :locationable, polymorphic: true, null: false
  end
end
