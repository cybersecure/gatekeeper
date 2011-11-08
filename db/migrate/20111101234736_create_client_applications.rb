class CreateClientApplications < ActiveRecord::Migration
  def change
    create_table :client_applications do |t|
      t.string :name
      t.string :client_id
      t.string :client_secret
      t.string :image_url
      t.string :description
      t.string :url
      t.boolean :cybersecure_app
    
      t.timestamps
    end
  end
end
