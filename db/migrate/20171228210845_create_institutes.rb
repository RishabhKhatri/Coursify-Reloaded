class CreateInstitutes < ActiveRecord::Migration[5.1]
  def change
    create_table :institutes do |t|
      t.string :name
      t.string :slug, unique: true
      t.string :profile
      t.string :background
      t.string :contact, unique: true
      t.string :email, unique: true
      t.string :invitation_code, unique: true
      t.text :about
      t.string :website

      t.timestamps
    end
  end
end
