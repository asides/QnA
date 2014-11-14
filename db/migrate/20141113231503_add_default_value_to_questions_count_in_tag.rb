class AddDefaultValueToQuestionsCountInTag < ActiveRecord::Migration
  def change
    change_column :tags, :questions_count, :integer, default: 0
  end
end
