class AddTotalVotedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :total_voted, :integer, default: 0
  end
end
