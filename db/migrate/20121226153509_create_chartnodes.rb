class CreateChartnodes < ActiveRecord::Migration
  def change
    create_table :chartnodes do |t|
      t.string :xaxis
      t.float :yaxis
      t.integer :chart_id

      t.timestamps
    end
  end
end
