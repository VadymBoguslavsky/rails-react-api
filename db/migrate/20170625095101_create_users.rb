class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :email_confirmation, default: false
      t.string :email_token
      t.string :password_digest
      t.string :token, default: ""

      t.timestamps
    end
  end
end
