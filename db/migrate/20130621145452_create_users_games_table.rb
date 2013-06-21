class CreateUsersGamesTable < ActiveRecord::Migration
  def change
    create_table :users_games do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :winner
      t.timestamps
    end
  end
end
