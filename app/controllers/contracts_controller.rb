class ContractsController < ApplicationController
  def index
    @contracts = Contract.includes(:contract_owner, :supplier).all
  end
end
