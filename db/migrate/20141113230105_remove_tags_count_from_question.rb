class RemoveTagsCountFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :tags_count
  end
end
