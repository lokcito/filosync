class CreateDataFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :data_files do |t|
      t.string :filename
      t.string :s3_path
      t.string :status
      t.string :columns
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
