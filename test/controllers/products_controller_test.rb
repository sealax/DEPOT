#---
# Excerpted from "Agile Web Development with Rails 8",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/rails8 for more book information.
#---
require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: {
        product: {
          description: @product.description,
          image: file_fixture_upload("lorem.jpg", "image/jpeg"),
          price: @product.price,
          title: @title
        }
      }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
      patch product_url(@product), params: {
        product: {
          description: @product.description,
          image: file_fixture_upload("lorem.jpg", "image/jpeg"),
          price: @product.price,
          title: @title
        }
      }

    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_raises ActiveRecord::RecordNotDestroyed do
      delete product_url(products(:two))
    end

    assert Product.exists?(products(:two).id)
  end
end
