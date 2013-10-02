class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :votes, null: false, default: 0
      t.belongs_to :user

      t.timestamps
    end
  end
end
