class CreateIssueFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :issue_files do |t|
      t.integer :line
      t.string :data_row
      t.string :issues
      t.references :data_files, null: false, foreign_key: true

      t.timestamps
    end
  end
end
