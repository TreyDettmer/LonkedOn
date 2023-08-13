class RenameUserBioToHeadline < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :bio, :headline
  end
end
