class CreateMetafields < ActiveRecord::Migration
  def change
    create_table :metafields do |t|
      t.string :type
      t.string :values
      t.string :title
      t.integer :order
      t.belongs_to :form

      t.timestamps
    end
  end
end
