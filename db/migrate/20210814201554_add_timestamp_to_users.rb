class AddTimestampToUsers < ActiveRecord::Migration[5.2]
  def change
    add_timestamps(:users, null: true)
  end
end
