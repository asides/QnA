class AddQuestionsCountToTag < ActiveRecord::Migration
  def change
    add_column :tags, :questions_count, :integer
  end
end
