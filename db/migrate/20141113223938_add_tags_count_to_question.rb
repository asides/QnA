class AddTagsCountToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :tags_count, :integer
  end
end
