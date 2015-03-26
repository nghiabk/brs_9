class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.datetime :publish_date
      t.integer :number_page
      t.integer :rating
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :books, :categories
  end
end
