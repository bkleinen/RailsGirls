class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :value
      t.belongs_to :registration
      t.belongs_to :metafield

      t.timestamps
    end
  end
end
