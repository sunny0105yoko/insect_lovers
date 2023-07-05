class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.integer :list_id
      t.integer :user_id
      t.timestamps
    end
  end
end
