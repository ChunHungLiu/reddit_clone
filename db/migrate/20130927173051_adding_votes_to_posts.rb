class AddingVotesToPosts < ActiveRecord::Migration
  def change
  	  change_table :posts do |t|
      	t.integer :votes, null: false, default: 0
      end
  end
end
