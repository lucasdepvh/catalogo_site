class HomeController < ApplicationController
  include Pagy::Backend

  skip_before_action :authenticate_admin!

  def index
    begin
      if params[:q].present?
        @min_price = params[:q][:price_gteq] || 0
        @max_price = params[:q][:price_lteq] || 999999
  
        @q = Product.ransack(params[:q])
        @products = @q.result
        @pagy, @products = pagy(@products)
      else
        @q = Product.ransack({}) # Inicialize @q mesmo sem parâmetros de busca
        @products = Product.all
        @pagy, @products = pagy(@products, items: @products.size) # Paginar mesmo sem busca
      end
  
      # Para depuração: mostrar a consulta SQL gerada (se houver)
      puts @q.result.to_sql if @q.present?
    rescue => exception
      
    end
  end

  def who_we_are
  end
end