class ChangeTypeRatingBook < ActiveRecord::Migration
  def change
    change_column :books, :rating, :float
  end
end
