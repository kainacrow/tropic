require 'rails_helper'

RSpec.describe ContractsController, type: :controller do
  describe 'GET #index' do
    let!(:supplier) { create(:supplier) }
    let!(:contracts) { create_list(:contract, 3, supplier: supplier) }

    it 'assigns all contracts to @contracts' do
      get :index
      expect(assigns(:contracts)).to eq(contracts)
    end

    it 'includes contract owners and suppliers in the query' do
      expect(Contract).to receive(:includes).with(:contract_owner, :supplier).and_call_original
      get :index
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
