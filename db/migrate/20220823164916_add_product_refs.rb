class AddProductRefs < ActiveRecord::Migration[7.0]
  def change
    add_reference :cart_items, :product, foreign_key: true
    add_reference :order_details, :product, foreign_key: true
    add_reference :product_reviews, :product, foreign_key: true
    add_reference :stores, :product, foreign_key: true
  end
end
