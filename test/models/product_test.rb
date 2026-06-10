require "test_helper"

class ProductTest < ActiveSupport::TestCase
test "product attributes must not be empty" do
  product = Product.new
  assert product.invalid?
  assert product.errors[:title].any?
  assert product.errors[:description].any?
  assert product.errors[:image].any?
  assert product.errors[:price].any?
end

test "product price must be positive" do
  product = Product.new(title: "Test Product", description: "This is a test product.", image: fixture_file_upload("test/fixtures/files/test_image.png", "image/png"))
  product.image.attach(io: File.open(Rails.root.join("test/fixtures/files/test_image.png")), filename: "test_image.png", content_type: "image/png")
  product.price = -1
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

  product.price = 0
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

  product.price = 1
  assert product.valid?
  assert product.errors[:price].empty?

end

def new_product(filename, content_type)
  Product.new(
    title: "Test Product",
    description: "This is a test product.",
    price: 1
  ).tap do |product|
    product.image.attach(
      io: File.open(Rails.root.join("test/fixtures/files/#{filename}")), filename: filename, content_type: content_type)
    end
end

test "image url" do
  product = new_product("test_image.png", "image/png")
  assert product.valid?, "image/jpeg must be valid"
  product = new_product("logo.svg", "image/svg+xml")
  assert_not product.valid?, "image/svg+xml must be valid"
  assert_equal ["must be a GIF, JPEG, or PNG"], product.errors[:image]

end

end
