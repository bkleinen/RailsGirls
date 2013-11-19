class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :name
      t.date :date
      t.text :description
      t.text :venue
      t.belongs_to :participant_form
      t.belongs_to :coach_form

      t.timestamps
    end
  end
end
