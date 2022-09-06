class AddUserRefs < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :user, foreign_key: true
    add_reference :sports_complexes, :user, foreign_key: true
    add_reference :carts, :user, foreign_key: true
    add_reference :order_details, :user, foreign_key: true
    add_reference :product_reviews, :user, foreign_key: true
    add_reference :stores, :user, foreign_key: true
    add_reference :transaction_details, :user,foreign_key: true
    add_reference :otps, :user, foreign_key: true
  end
end
