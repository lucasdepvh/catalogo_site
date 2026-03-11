class ProductsController < ApplicationController
    skip_before_action :authenticate_admin!
    
    def show
        @product = Product.find(params[:id])
        @relateds_products = Product.related_to(@product)[0..3]
    end
end