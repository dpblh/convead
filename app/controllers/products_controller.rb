class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :similar]

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
  end

  def similar
    start = Time.now
    @products =  Product.similar(@product)
    end0 = Time.now
    @timesql = "#{end0 - start} время запроса";
    # render :show
    respond_to do |format|
      format.html {render action: :index, notice: "Similar #{end0 - start}"}
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params[:product]
    end
end
