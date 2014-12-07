class CreateCreateXobjects < ActiveRecord::Migration
  def change
    create_table :create_xobjects do |t|
      t.string :uid, index: true, null: false, unique: true
      t.string :arb_object

      t.timestamps null: false
    end
  end
end
