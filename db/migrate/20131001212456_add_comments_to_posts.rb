class AddCommentsToPosts < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
  		t.belongs_to :post
  	end
  end
end
