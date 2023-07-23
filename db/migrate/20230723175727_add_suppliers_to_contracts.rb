class AddSuppliersToContracts < ActiveRecord::Migration[7.0]
  def change
    add_reference(:contracts, :supplier, index:true, foreign_key: true)
  end
end
