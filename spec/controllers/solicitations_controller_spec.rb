# frozen_string_literal: true

require 'rails_helper'
require 'devise'
# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe SolicitationsController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let(:admin) { FactoryGirl.create :admin }
  # This should return the minimal set of attributes required to create a valid
  # Solicitation. As you add validations to Solicitation, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { kind: 'diaria',
      departure: '2013-02-02',
      return: '2013-02-03',
      origin: 'Origin',
      destination: 'Destination',
      description: 'MyText',
      status: 'analise',
      user: user,
      created_at: '2012-02-02',
      updated_at: '2012-02-02' }
  end

  let(:invalid_attributes) do
    { kind: 'diaria',
      departure: '2013-02-02',
      return: nil,
      origin: 'Origin',
      destination: 'Destination',
      description: 'MyText',
      status: 'analise',
      user: user,
      created_at: '2012-02-02',
      updated_at: '2012-02-02' }
  end

  before do
    Budget.create!(value: 0.0) if Budget.count < 1
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SolicitationsController. Be sure to keep this updated too.
  let(:admin_session) { sign_in admin }
  let(:user_session) { sign_in user }
  let(:guest_session) { {} }

  @setup = Setup.create(inicio: '2011-01-13 13:13:13 -0300',
                        fim: '2013-02-14 13:13:13 -0300')

  now = Time.parse('2012-01-01 12:00:00 -0300')
  after = Time.parse('2040-01-01 12:00:00 -0300')
  let(:covered) { allow(Time).to receive(:now) { now } }
  let(:not_covered) { allow(Time).to receive(:now) { after } }

  describe 'GET #index' do
    context 'when user  or admin is logged in' do
      it 'returns a success response' do
        Solicitation.create! valid_attributes
        get :index, params: {}, session: admin_session
        expect(response).to be_successful
      end
    end
    context 'when user is logged in' do
      it 'returns a success response' do
        Solicitation.create! valid_attributes
        get :index, params: {}, session: user_session
        expect(response).to be_successful
      end
    end
    context 'when user is a guest' do
      it 'it does not return a success response' do
        Solicitation.create! valid_attributes
        get :index, params: {}, session: guest_session
        expect(response).not_to be_successful
      end
    end
  end
  describe 'GET #show' do
    context 'when admin is logged in' do
      it 'returns a success response' do
        solicitation = Solicitation.create! valid_attributes
        get :show, params: { id: solicitation.to_param }, session: admin_session
        expect(response).to be_successful
      end
    end

    context 'when user is logged in' do
      it 'returns a success response' do
        solicitation = Solicitation.create! valid_attributes
        get :show, params: { id: solicitation.to_param }, session: user_session
        expect(response).to be_successful
      end
    end

    context 'when user is a guest' do
      it 'it does not return a success response' do
        solicitation = Solicitation.create! valid_attributes
        get :show, params: { id: solicitation.to_param }, session: guest_session
        expect(response).not_to be_successful
      end
    end
  end

  describe 'GET #new' do
    context 'when time is covered' do
      before(:each) do
        covered
      end
      context 'when user is logged as admin' do
        it 'returns a success response' do
          get :new, params: {}, session: admin_session
          expect(response).to be_successful
        end
      end

      context 'when user is logged in' do
        it 'returns a success response' do
          get :new, params: {}, session: user_session
          expect(response).to be_successful
        end
      end

      context 'when user is a guest' do
        it 'it does not return a success response' do
          get :new, params: {}, session: guest_session
          expect(response).not_to be_successful
        end
      end
    end

    context 'when time is not covered' do
      before(:each) do
        not_covered
      end
      context 'when user is logged as admin' do
        it 'it does not return a success response' do
          get :new, params: {}, session: admin_session
          expect(response).not_to be_successful
        end
      end

      context 'when user is logged in' do
        it 'it does not return a success response' do
          get :new, params: {}, session: user_session
          expect(response).not_to be_successful
        end
      end

      context 'when user is a guest' do
        it 'it does not return a success response' do
          get :new, params: {}, session: guest_session
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      solicitation = Solicitation.create! valid_attributes
      get :edit, params: { id: solicitation.to_param }, session: admin_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'when admin is logged in' do
      context 'with valid params' do
        it 'creates a new Solicitation' do
          expect do
            post :create, params: { solicitation: valid_attributes }, session: admin_session
          end.to change(Solicitation, :count).by(1)
        end

        it 'redirects to the created solicitation' do
          post :create, params: { solicitation: valid_attributes }, session: admin_session
          expect(response).to redirect_to(Solicitation.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { solicitation: invalid_attributes }, session: admin_session
          expect(response).to be_successful
        end
      end
    end

    context 'when user is logged in ' do
      context 'with valid params' do
        it 'creates a new Solicitation' do
          expect do
            post :create, params: { solicitation: valid_attributes }, session: user_session
          end.to change(Solicitation, :count).by(1)
        end

        it 'redirects to the created solicitation' do
          post :create, params: { solicitation: valid_attributes }, session: user_session
          expect(response).to redirect_to(Solicitation.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { solicitation: invalid_attributes }, session: user_session
          expect(response).to be_successful
        end
      end
    end

    context 'when user is a guest ' do
      context 'with valid params' do
        it 'it does not create a new Solicitation' do
          expect do
            post :create, params: { solicitation: valid_attributes }, session: guest_session
          end.to change(Solicitation, :count).by(0)
        end

        it 'it does not redirect to the created solicitation' do
          post :create, params: { solicitation: valid_attributes }, session: guest_session
          expect(response).not_to redirect_to(Solicitation.last)
        end
      end

      context 'with invalid params' do
        it "it does not return a success response (i.e. to display the 'new' template)" do
          post :create, params: { solicitation: invalid_attributes }, session: guest_session
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) do
      { kind: 'diaria',
        departure: '2013-02-02',
        return: '2013-02-03',
        origin: 'Origem',
        destination: 'Destino',
        description: 'Textinho',
        status: 'analise',
        user: user,
        created_at: '2012-02-02',
        updated_at: '2012-02-02' }
    end
    context 'when admin is logged in' do
      context 'with valid params' do
        it 'updates the requested solicitation' do
          solicitation = Solicitation.create! valid_attributes
          put :update, params: { id: solicitation.to_param, solicitation: new_attributes }, session: admin_session
          solicitation.reload
          expect(solicitation.origin).to eq('Origem')
          expect(solicitation.destination).to eq('Destino')
          expect(solicitation.description).to eq('Textinho')
        end

        it 'redirects to the solicitation' do
          solicitation = Solicitation.create! valid_attributes
          put :update, params: { id: solicitation.to_param, solicitation: valid_attributes }, session: admin_session
          expect(response).to redirect_to(solicitation)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          solicitation = Solicitation.create! valid_attributes
          put :update, params: { id: solicitation.to_param, solicitation: invalid_attributes }, session: admin_session
          expect(response).to be_successful
        end
      end
    end

    context 'when user is logged in' do
      context 'with valid params' do
        it 'it does not update the requested solicitation' do
          solicitation = Solicitation.create! valid_attributes
          put :update, params: { id: solicitation.to_param, solicitation: new_attributes }, session: user_session
          solicitation.reload
          expect(solicitation.origin).not_to eq('Origem')
          expect(solicitation.destination).not_to eq('Destino')
          expect(solicitation.description).not_to eq('Textinho')
        end

        it 'it does not redirect to the solicitation' do
          solicitation = Solicitation.create! valid_attributes
          put :update, params: { id: solicitation.to_param, solicitation: valid_attributes }, session: user_session
          expect(response).not_to redirect_to(solicitation)
        end
      end

      context 'with invalid params' do
        it "it does not return a success response (i.e. to display the 'edit' template)" do
          solicitation = Solicitation.create! valid_attributes
          put :update, params: { id: solicitation.to_param, solicitation: invalid_attributes }, session: user_session
          expect(response).not_to be_successful
        end
      end
    end

    context 'when user is a guest' do
      context 'with valid params' do
        it 'it does not update the requested solicitation' do
          solicitation = Solicitation.create! valid_attributes
          put :update, params: { id: solicitation.to_param, solicitation: new_attributes }, session: guest_session
          solicitation.reload
          expect(solicitation.origin).not_to eq('Origem')
          expect(solicitation.destination).not_to eq('Destino')
          expect(solicitation.description).not_to eq('Textinho')
        end

        it 'it does not redirect to the solicitation' do
          solicitation = Solicitation.create! valid_attributes
          put :update, params: { id: solicitation.to_param, solicitation: valid_attributes }, session: guest_session
          expect(response).not_to redirect_to(solicitation)
        end
      end

      context 'with invalid params' do
        it "it does not return a success response (i.e. to display the 'edit' template)" do
          solicitation = Solicitation.create! valid_attributes
          put :update, params: { id: solicitation.to_param, solicitation: invalid_attributes }, session: guest_session
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when admin is logged in' do
      it 'destroys the requested solicitation' do
        solicitation = Solicitation.create! valid_attributes
        expect do
          delete :destroy, params: { id: solicitation.to_param }, session: admin_session
        end.to change(Solicitation, :count).by(-1)
      end

      it 'redirects to the solicitations list' do
        solicitation = Solicitation.create! valid_attributes
        delete :destroy, params: { id: solicitation.to_param }, session: admin_session
        expect(response).to redirect_to(solicitations_url)
      end
    end

    context 'when user is signed in' do
      it 'destroys the requested solicitation' do
        solicitation = Solicitation.create! valid_attributes
        expect do
          delete :destroy, params: { id: solicitation.to_param }, session: user_session
        end.to change(Solicitation, :count).by(0)
      end

      it 'redirects to the solicitations list' do
        solicitation = Solicitation.create! valid_attributes
        delete :destroy, params: { id: solicitation.to_param }, session: user_session
        expect(response).to redirect_to(solicitations_url)
      end
    end

    context 'when user is a guest' do
      it 'it does not destroy the requested solicitation' do
        solicitation = Solicitation.create! valid_attributes
        expect do
          delete :destroy, params: { id: solicitation.to_param }, session: guest_session
        end.to change(Solicitation, :count).by(0)
      end

      it 'it does not redirect to the solicitations list' do
        solicitation = Solicitation.create! valid_attributes
        delete :destroy, params: { id: solicitation.to_param }, session: guest_session
        expect(response).not_to redirect_to(solicitations_url)
      end
    end
  end

  describe 'ACCEPT #accept' do
    context 'when user is logged as admin' do
      context 'when there is enough money'  do
        it 'changes Budget value, changes status to aprovado and redirects to solicitations path' do
          solicitation = Solicitation.create! valid_attributes
          Budget.first.update_attribute(:value, 1000)
          get :accept , params: {id: solicitation.to_param }, session: admin_session
          solicitation.reload
          expect(response).to redirect_to(solicitations_url)
          expect(Budget.first.value).to eq(200)
          expect(solicitation.status).to eq('aprovado')
        end
      end
      context 'when there is not enough money' do
        it 'does not change Budget value and change status to aprovado redirects to solicitations path' do
          solicitation = Solicitation.create! valid_attributes
          Budget.first.update_attribute(:value, 100)
          get :accept , params: {id: solicitation.to_param }, session: admin_session
          solicitation.reload
          expect(response).to redirect_to(solicitations_url)
          expect(Budget.first.value).to eq(100)
          expect(solicitation.status).not_to eq('aprovado')

        end
      end
    end

    context 'when user is logged in' do
      context 'when there is enough money' do
        it 'does not change Budget value or status to aprovado and redirects to solicitations path' do
          solicitation = Solicitation.create! valid_attributes
          Budget.first.update_attribute(:value, 1000)
          get :accept , params: {id: solicitation.to_param }, session: user_session
          solicitation.reload
          expect(response).to redirect_to(solicitations_url)
          expect(Budget.first.value).to eq(1000)
        end
      end
      context 'when there is not enough money' do
        it 'does not change Budget value and change status to aprovado redirects to solicitations path' do
          solicitation = Solicitation.create! valid_attributes
          Budget.first.update_attribute(:value, 100)
          get :accept , params: {id: solicitation.to_param }, session: user_session
          solicitation.reload
          expect(response).to redirect_to(solicitations_url)
          expect(Budget.first.value).to eq(100)
        end
      end
    end

    context 'when user is a guest' do
      context 'when there is enough money' do
        it 'does not change Budget value or status to aprovado and redirects to solicitations path' do
          solicitation = Solicitation.create! valid_attributes
          Budget.first.update_attribute(:value, 1000)
          get :accept , params: {id: solicitation.to_param }, session: guest_session
          solicitation.reload
          expect(response).to redirect_to(new_user_session_path)
          expect(Budget.first.value).to eq(1000)
        end
      end
      context 'when there is not enough money' do
        it 'does not change Budget value and change status to aprovado redirects to solicitations path' do
          solicitation = Solicitation.create! valid_attributes
          Budget.first.update_attribute(:value, 100)
          get :accept , params: {id: solicitation.to_param }, session: guest_session
          solicitation.reload
          expect(response).to redirect_to(new_user_session_path)
          expect(Budget.first.value).to eq(100)
        end
      end
    end
  end

  describe 'REFUSE #refuse' do
    context 'when user is logged as admin' do
      it 'updates status to Reprovado and redirects to solicitations page' do
        solicitation = Solicitation.create! valid_attributes
        get :refuse , params: {id: solicitation.to_param }, session: admin_session
        solicitation.reload
        expect(response).to redirect_to(solicitations_url)
        expect(solicitation.status).to eq('reprovado')
      end
    end

    context 'when user is logged' do
      it 'does not update status to Reprovado and redirects to sign in page' do
        solicitation = Solicitation.create! valid_attributes
        get :refuse , params: {id: solicitation.to_param }, session: user_session
        solicitation.reload
        expect(response).to redirect_to(solicitations_url)
        expect(solicitation.status).not_to eq('reprovado')
      end
    end

    context 'when user is a guest' do
      it 'does not update status to Reprovado and redirects to sign in page' do
        solicitation = Solicitation.create! valid_attributes
        get :refuse , params: {id: solicitation.to_param }, session: guest_session
        solicitation.reload
        expect(response).to redirect_to(new_user_session_path)
        expect(solicitation.status).not_to eq('reprovado')
      end
    end
  end


end
