class RenamingPostIdToItemId < ActiveRecord::Migration
  def change
  	change_table :votes do |t|
  		t.integer :item_id
  		t.remove :post_id
  	end
  end
end
