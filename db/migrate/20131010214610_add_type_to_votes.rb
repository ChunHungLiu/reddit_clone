class AddTypeToVotes < ActiveRecord::Migration
  def change
  	change_table :votes do |t|
  		t.string :type
  	end
  end
end
