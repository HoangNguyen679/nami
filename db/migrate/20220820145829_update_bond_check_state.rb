class UpdateBondCheckState < ActiveRecord::Migration[7.0]
  def up
    add_check_constraint :bonds, "state IN ('requesting', 'following', 'blocking')", name: 'allowed_state'
  end

  def down
    remove_check_constraint :bonds, name: 'allowed_state'
  end
end
