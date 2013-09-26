class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string :name
      t.string :url
      t.integer :number

      t.timestamps
    end
  end
end
