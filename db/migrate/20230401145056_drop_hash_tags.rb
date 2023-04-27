class DropHashTags < ActiveRecord::Migration[6.1]
  def change
    drop_table :hash_tags
  end
end
