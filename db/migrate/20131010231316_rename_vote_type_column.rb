class RenameVoteTypeColumn < ActiveRecord::Migration
  def change
  	change_table :votes do |t|
  		t.remove :type
  		t.string :item_type
  	end
  end
end
