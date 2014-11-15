class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
