class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
	
      t.string :url
      t.timestamps
    end
  end
end
