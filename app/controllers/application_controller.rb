class ApplicationController < ActionController::Base
    before_action :authenticate_admin!, except: :product_image_show
    include Pagy::Backend

    def product_image_show
        @product_image = ProductImage.find(params[:id])
        send_data @product_image.data, type: @product_image.filetype, disposition: 'inline'
    end
end
