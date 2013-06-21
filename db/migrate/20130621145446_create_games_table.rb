class CreateGamesTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :finished_at
      t.timestamps
    end
  end
end
