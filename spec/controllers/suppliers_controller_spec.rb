require 'rails_helper'

RSpec.describe SuppliersController, type: :controller do
  describe 'GET #show' do
    context 'when the supplier exists' do
      let(:supplier) { create(:supplier) }
      let!(:contracts) { create_list(:contract, 3, supplier: supplier, value_cents: 1000000) }

      it 'assigns the requested supplier to @supplier' do
        get :show, params: { id: supplier.id }
        expect(assigns(:supplier)).to eq(supplier)
      end

      it 'assigns contracts associated with the supplier to @contracts' do
        get :show, params: { id: supplier.id }
        expect(assigns(:contracts)).to eq(contracts)
      end

      it 'assigns the average contract value to @average_contract_value' do
        get :show, params: { id: supplier.id }
        average_contract_value = 1000000
        expect(assigns(:average_contract_value)).to eq("$10,000.00")
      end

      it 'renders the show template' do
        get :show, params: { id: supplier.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when the supplier does not exist' do
      it 'responds with 404 status' do
        expect {
          get :show, params: { id: 999 } # Assuming no supplier has an id of 999 in this test setup
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
