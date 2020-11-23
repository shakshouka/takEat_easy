class CreateWeeks < ActiveRecord::Migration[6.0]
  def change
    create_table :weeks do |t|
      t.references :user, null: false, foreign_key: true
      t.date :start_day

      t.timestamps
    end
  end
end
