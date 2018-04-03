class AddNameToSeason < ActiveRecord::Migration
  def change
    add_column :seasons, :name_cd, :integer
  end
end
