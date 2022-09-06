class CreateOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :otps do |t|
      t.bigint :mobile_number, unique:true, index:true
      t.integer :otp
      t.boolean :verified, default: false

      t.timestamps
    end
  end
end
