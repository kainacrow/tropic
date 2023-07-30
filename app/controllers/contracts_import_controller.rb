require 'csv'

class ContractsImportController < ApplicationController
  def new
  end

  def create
    if params[:csv_file]
      import_csv(params[:csv_file])
      redirect_to contracts_path, notice: "CSV import successful."
    else
      redirect_to contracts_path, alert: "No CSV file selected."
    end
  end

  private

  def import_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      contract_params = row.to_h

      supplier_name = contract_params["Supplier"].strip
      formatted_name = supplier_name.downcase.gsub(' ', '').gsub(',llc', '').gsub('llc', '')
      supplier = Supplier.find_by("LOWER(REPLACE(name, ' ', '')) LIKE ?", "%#{formatted_name}%")

      supplier ||= Supplier.new(name: contract_params["Supplier"])
      contract_owner = ContractOwner.find_or_initialize_by(email: contract_params["Contract Owner"])

      contract = Contract.find_or_initialize_by(external_contract_id: contract_params["External Contract ID"])

      contract.assign_attributes(
          name: contract_params["Contract Name"],
          contract_owner: contract_owner,
          supplier: supplier,
          start_date: Date.strptime(contract_params["Start Date"], "%m/%d/%Y"),
          end_date: Date.strptime(contract_params["End Date"], "%m/%d/%Y"),
          value_cents: (contract_params["Contract Value"]&.gsub(/[^\d\.]/, '').to_f * 100).to_i
      )

      contract.save
    rescue StandardError => e
      Rails.logger.error("Error importing CSV row: #{e.message}")
    end
  end
end
