class AddTotalVotedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :total_voted, :integer, default: 0
  end
end
