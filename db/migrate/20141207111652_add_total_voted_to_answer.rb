class AddTotalVotedToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :total_voted, :integer, default: 0
  end
end
