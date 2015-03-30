class ChangeColumnLikeTable < ActiveRecord::Migration
  def change
    rename_column :likes, :book_id, :activity_id
  end
end
