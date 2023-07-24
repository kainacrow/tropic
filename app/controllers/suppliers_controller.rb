class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.find(params[:id])
    @contracts = @supplier.contracts
  end
end
