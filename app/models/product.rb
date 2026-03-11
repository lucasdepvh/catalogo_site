class Product < ApplicationRecord
  belongs_to :category
  has_many :images, class_name: 'ProductImage', dependent: :destroy

  scope :related_to, ->(product) { where("category_id = #{product.category_id} AND id != #{product.id}") }

  accepts_nested_attributes_for :images, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "price", "title", "updated_at", "identification_code"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "images"]
  end

end
