class CreateAcnts < ActiveRecord::Migration[6.0]
  def change
    create_table :acnts do |t|
      t.string :email
      t.string :pass
      t.integer :usr_id
      t.integer :active

      t.timestamps
    end
  end
end
