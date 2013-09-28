class AddingVotesToPosts < ActiveRecord::Migration
  def change
  	  change_table :posts do |t|
      	t.integer :votes
      end
  end
end
