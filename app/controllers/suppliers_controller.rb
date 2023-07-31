class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.includes(contracts: :contract_owner).find(params[:id])
    @contracts = @supplier.contracts
    @average_contract_value = calculate_average_contract_value(@contracts)
  end

  def calculate_average_contract_value(contracts)
    return 0 if contracts.nil?

    total_value_cents = contracts.sum(:value_cents)
    average_value_cents = total_value_cents / contracts.length
    Money.new(average_value_cents, "USD").format
  end
end
