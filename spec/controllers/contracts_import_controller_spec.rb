require 'rails_helper'

RSpec.describe ContractsImportController, type: :controller do
  describe 'POST #create' do
    file_name = File.join(
      Rails.root,
      ["spec", "files", "contracts_import", "contracts-and-suppliers-spec.csv"]
    )
    let(:csv_file) { fixture_file_upload(file_name, 'text/csv') }

    context 'when a CSV file is uploaded' do
      it 'imports the CSV data and creates contracts with suppliers' do
        expect do
          post :create, params: { csv_file: csv_file }
        end.to change(Contract, :count).by(3)

        contracts = Contract.last(3)
        contracts.each do |contract|
          expect(contract.supplier).to be_present
        end
      end

      it 'redirects to contracts_path with a success notice' do
        post :create, params: { csv_file: csv_file }
        expect(response).to redirect_to(contracts_path)
        expect(flash[:notice]).to eq("CSV import successful.")
      end
    end

    context 'when no CSV file is uploaded' do
      it 'redirects to contracts_path with an alert' do
        post :create
        expect(response).to redirect_to(contracts_path)
        expect(flash[:alert]).to eq("No CSV file selected.")
      end

      it 'does not create any contracts' do
        expect do
          post :create
        end.not_to change(Contract, :count)
      end
    end
  end
end
