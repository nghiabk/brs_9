class CreateImageBooks < ActiveRecord::Migration
  def change
    create_table :image_books do |t|
      t.string :image
      t.boolean :important
      t.references :book, index: true

      t.timestamps null: false
    end
    add_foreign_key :image_books, :books
  end
end
