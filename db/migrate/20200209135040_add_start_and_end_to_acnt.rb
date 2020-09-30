class AddStartAndEndToAcnt < ActiveRecord::Migration[6.0]
  def change
    add_column :acnts, :start, :datetime
    add_column :acnts, :end, :datetime
  end
end
