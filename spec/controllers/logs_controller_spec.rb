require 'rails_helper'

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

RSpec.describe LogsController, type: :controller do
  let(:admin) { FactoryGirl.create :admin }
  let(:user) { FactoryGirl.create :user }


  before do
    if Budget.count < 1
      Budget.create!(value: 0.0)
    end
  end
  # This should return the minimal set of attributes required to create a valid
  # Log. As you add validations to Log, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do

    { value: 100, description: 'MyText', budget: Budget.first }
  end

  let(:invalid_attributes) do
    { value: nil, description: 'MyText', budget: Budget.first }
  end


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LogsController. Be sure to keep this updated too.
  let(:admin_session) { sign_in admin }
  let(:user_session) {sign_in user}
  let(:guest_session) {{}}

  context 'when admin is logged in' do

    describe "GET #index" do
      it "does not return a success response" do
        Log.create! valid_attributes
        get :index, params: {}, session: admin_session
        expect(response).not_to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        log = Log.create! valid_attributes
        get :show, params: { id: log.to_param }, session: admin_session
        expect(response).to be_successful
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new, params: {}, session: admin_session
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "returns a success response" do
        log = Log.create! valid_attributes
        get :edit, params: { id: log.to_param }, session: admin_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Log" do
          expect {
            post :create, params: { log: valid_attributes }, session: admin_session
          }.to change(Log, :count).by(1)
        end

        it "redirects to the created log" do
          post :create, params: { log: valid_attributes }, session: admin_session
          expect(response).to redirect_to(budgets_path)
        end

        it 'adds value to budget value ' do
          old_value = Budget.first.value
          post :create, params: { log: valid_attributes }, session: admin_session
          expect(Budget.first.value).to eq(old_value + Log.last.value)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { log: invalid_attributes }, session: admin_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) do
          { value: 500, description: 'text', budget: Budget.first }
        end

        it "updates the requested log" do
          log = Log.create! valid_attributes
          put :update, params: { id: log.to_param, log: new_attributes }, session: admin_session
          log.reload
          expect(log.value).to eq(500)
          expect(log.description).to eq('text')
        end

        it "redirects to the log" do
          log = Log.create! valid_attributes
          put :update, params: { id: log.to_param, log: valid_attributes }, session: admin_session
          expect(response).to redirect_to(log)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          log = Log.create! valid_attributes
          put :update, params: { id: log.to_param, log: invalid_attributes }, session: admin_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested log" do
        log = Log.create! valid_attributes
        expect {
          delete :destroy, params: { id: log.to_param }, session: admin_session
        }.to change(Log, :count).by(-1)
      end

      it "redirects to the logs list" do
        log = Log.create! valid_attributes
        delete :destroy, params: { id: log.to_param }, session: admin_session
        expect(response).to redirect_to(budgets_path)
      end
    end
  end

  context 'when user is logged in' do

    describe "GET #index" do
      it "does not return a success response" do
        Log.create! valid_attributes
        get :index, params: {}, session: user_session
        expect(response).not_to be_successful
      end
    end

    describe "GET #show" do
      it "does not return a success response" do
        log = Log.create! valid_attributes
        get :show, params: { id: log.to_param }, session: user_session
        expect(response).not_to be_successful
      end
    end

    describe "GET #new" do
      it "does not return a success response" do
        get :new, params: {}, session: user_session
        expect(response).not_to be_successful
      end
    end

    describe "GET #edit" do
      it "does not return a success response" do
        log = Log.create! valid_attributes
        get :edit, params: { id: log.to_param }, session: user_session
        expect(response).not_to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "does not create a new Log" do
          expect {
            post :create, params: { log: valid_attributes }, session: user_session
          }.to change(Log, :count).by(0)
        end

        it "does not redirect to the created log" do
          post :create, params: { log: valid_attributes }, session: user_session
          expect(response).not_to redirect_to(budgets_path)
        end

        it 'does not add value to budget value ' do
          Budget.create(value: 100)
          old_value = Budget.first.value
          post :create, params: { log: valid_attributes }, session: user_session
          expect(Budget.first.value).not_to eq(old_value + 100)
        end
      end

      context "with invalid params" do
        it "does not return a success response (i.e. to display the 'new' template)" do
          post :create, params: { log: invalid_attributes }, session: user_session
          expect(response).not_to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { value: 500, description: 'text', budget_id: Budget.first.id }
        }

        it "does not update the requested log" do
          log = Log.create! valid_attributes
          put :update, params: { id: log.to_param, log: new_attributes }, session: user_session
          log.reload
          expect(log.value).not_to eq(500)
          expect(log.description).not_to eq('text')
        end

        it "redirects to the budget list" do
          log = Log.create! valid_attributes
          put :update, params: { id: log.to_param, log: valid_attributes }, session: user_session
          expect(response).to redirect_to(root_path)
        end
      end

      context "with invalid params" do
        it "does not return a success response (i.e. to display the 'edit' template)" do
          log = Log.create! valid_attributes
          put :update, params: { id: log.to_param, log: invalid_attributes }, session: user_session
          expect(response).not_to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "does not destroy the requested log" do
        log = Log.create! valid_attributes
        expect {
          delete :destroy, params: { id: log.to_param }, session: user_session
        }.to change(Log, :count).by(0)
      end

      it "redirects to the budgets list" do
        log = Log.create! valid_attributes
        delete :destroy, params: { id: log.to_param }, session: user_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context 'when user is a guest' do

    describe "GET #index" do
      it "does not return a success response" do
        Log.create! valid_attributes
        get :index, params: {}, session: guest_session
        expect(response).not_to be_successful
      end
    end

    describe "GET #show" do
      it "does not return a success response" do
        log = Log.create! valid_attributes
        get :show, params: { id: log.to_param }, session: guest_session
        expect(response).not_to be_successful
      end
    end

    describe "GET #new" do
      it "does not return a success response" do
        get :new, params: {}, session: guest_session
        expect(response).not_to be_successful
      end
    end

    describe "GET #edit" do
      it "does not return a success response" do
        log = Log.create! valid_attributes
        get :edit, params: { id: log.to_param }, session: guest_session
        expect(response).not_to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "does not create a new Log" do
          expect {
            post :create, params: { log: valid_attributes }, session: guest_session
          }.to change(Log, :count).by(0)
        end

        it "does not redirect to the created log" do
          post :create, params: { log: valid_attributes }, session: guest_session
          expect(response).to redirect_to(root_path)
        end

        it 'does not add value to budget value ' do
          old_value = Budget.first.value
          post :create, params: { log: valid_attributes }, session: guest_session
          expect(Budget.first.value).not_to eq(old_value + 100)
        end
      end

      context "with invalid params" do
        it "does not return a success response (i.e. to display the 'new' template)" do
          post :create, params: { log: invalid_attributes }, session: guest_session
          expect(response).not_to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { value: 500, description: 'text', budget_id: Budget.first.id }
        }

        it "does not update the requested log" do
          log = Log.create! valid_attributes
          put :update, params: { id: log.to_param, log: new_attributes }, session: guest_session
          log.reload
          expect(log.value).not_to eq(500)
          expect(log.description).not_to eq('text')
        end

        it "redirects to the budget list" do
          log = Log.create! valid_attributes
          put :update, params: { id: log.to_param, log: valid_attributes }, session: guest_session
          expect(response).to redirect_to(root_path)
        end
      end

      context "with invalid params" do
        it "does not return a success response (i.e. to display the 'edit' template)" do
          log = Log.create! valid_attributes
          put :update, params: { id: log.to_param, log: invalid_attributes }, session: guest_session
          expect(response).not_to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "does not destroy the requested log" do
        log = Log.create! valid_attributes
        expect {
          delete :destroy, params: { id: log.to_param }, session: guest_session
        }.to change(Log, :count).by(0)
      end

      it "redirects to the budgets list" do
        log = Log.create! valid_attributes
        delete :destroy, params: { id: log.to_param }, session: guest_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
