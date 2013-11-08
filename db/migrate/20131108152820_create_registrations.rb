class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :twitter
      t.text :programming
      t.text :railsexperience
      t.text :motivation
      t.string :os
      t.string :specialdiat

      t.timestamps
    end
  end
end
