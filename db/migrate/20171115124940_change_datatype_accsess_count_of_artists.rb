class ChangeDatatypeAccsessCountOfArtists < ActiveRecord::Migration
  def change
    change_column :artists, :accsess_count, :integer
  end
end
