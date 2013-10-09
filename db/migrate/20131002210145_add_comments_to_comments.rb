class AddCommentsToComments < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
  		t.belongs_to :comment
  	end
  end
end
