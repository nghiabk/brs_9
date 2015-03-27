class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.boolean :important
      t.string :image
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
