class TimePeriod < ActiveRecord::Migration[5.2]
  def change
    create_table :time_periods do |t|
      t.datetime :starts
      t.datetime :finishes

      t.string :name
      t.text :description

      t.references :task
      t.references :attempt
      t.references :phase
      t.references :try

      t.timestamps
    end
  end
end
