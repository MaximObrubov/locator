class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :address
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
