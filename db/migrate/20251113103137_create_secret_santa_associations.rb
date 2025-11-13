class CreateSecretSantaAssociations < ActiveRecord::Migration[8.0]
  def change
    create_table :secret_santa_associations do |t|
      t.references :giver, :null => false, :foreign_key => {:to_table => :employees}
      t.references :recipient, :null => false, :foreign_key => {:to_table => :employees}
      t.integer :year , :null => false
      t.timestamps
    end
  end
end
