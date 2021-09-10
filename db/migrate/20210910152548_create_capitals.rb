class CreateCapitals < ActiveRecord::Migration[6.1]
  def change
    create_table :capitals do |t|
      t.string :name
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
