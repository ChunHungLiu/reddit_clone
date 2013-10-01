class AddPostIdToVotes < ActiveRecord::Migration
  def change
  	change_table :votes do |t|
  		t.integer :post_id
  	end
  end
end
