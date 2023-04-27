class DropPostHashTags < ActiveRecord::Migration[6.1]
  def change
    drop_table :post_hash_tags
  end
end
