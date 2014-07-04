require 'rails_helper'

describe ResourcesController do
  let(:valid_session) { {} }

  let(:resource) { FactoryGirl.create(:resource) }
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:resource) }

  describe "GET show" do
    it "assigns the requested resource as @resource" do
      get :show, { id: resource.to_param }
      expect(assigns(:resource)).to eq(resource)
    end
  end

  describe "GET new" do
    it "assigns a new resource as @resource" do
      sign_in user
      get :new
      expect(assigns(:resource)).to be_a_new(Resource)
    end
  end

  describe "GET edit" do
    it "assigns the requested resource as @resource" do
      sign_in user
      get :edit, { id: resource.to_param }
      expect(assigns(:resource)).to eq(resource)
    end
  end

  describe "POST create" do
    before(:each) { sign_in user }
    describe "with valid params" do
      it "creates a new Resource" do
        expect {
          post :create, {:resource => valid_attributes}
        }.to change(Resource, :count).by(1)
      end

      it "assigns a newly created resource as @resource" do
        post :create, {:resource => valid_attributes}
        expect(assigns(:resource)).to be_a(Resource)
        expect(assigns(:resource)).to be_persisted
      end

      it "redirects to the created resource" do
        post :create, {:resource => valid_attributes}
        expect(response).to redirect_to(Resource.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved resource as @resource" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Resource).to receive(:save).and_return(false)
        post :create, {:resource => { title: "foo" }}
        expect(assigns(:resource)).to be_a_new(Resource)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Resource).to receive(:save).and_return(false)
        post :create, {:resource => { title: "foo" }}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PATCH update" do
    before(:each) { sign_in user }
    describe "with valid params" do
      it "updates the requested resource" do
        resource = Resource.create! valid_attributes
        # Assuming there are no other resources in the database, this
        # specifies that the Resource created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        allow_any_instance_of(Resource).to receive(:update_attributes).with({})
        patch :update, {:id => resource.to_param, :resource => { "these" => "params" }}, valid_session
      end

      it "assigns the requested resource as @resource" do
        resource = Resource.create! valid_attributes
        patch :update, {:id => resource.to_param, :resource => valid_attributes}, valid_session
        expect(assigns(:resource)).to eq(resource)
      end

      it "redirects to the resource" do
        resource = Resource.create! valid_attributes
        patch :update, {:id => resource.to_param, :resource => valid_attributes}, valid_session
        expect(response).to redirect_to(resource)
      end
    end

    describe "with invalid params" do
      it "assigns the resource as @resource" do
        resource = Resource.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Resource).to receive(:save).and_return(false)
        patch :update, {:id => resource.to_param, :resource => { title: "" }}, valid_session
        expect(assigns(:resource)).to eq(resource)
      end

      it "re-renders the 'edit' template" do
        resource = Resource.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Resource).to receive(:save).and_return(false)
        patch :update, {:id => resource.to_param, :resource => { title: "" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) {
      sign_in user
      request.env["HTTP_REFERER"] = "I'm a little teapot"
    }
    it "destroys the requested resource" do
      resource = Resource.create! valid_attributes
      expect {
        delete :destroy, {:id => resource.to_param}, valid_session
      }.to change(Resource, :count).by(-1)
    end

    it "redirects to the resources list" do
      resource = Resource.create! valid_attributes
      delete :destroy, {:id => resource.to_param}, valid_session
      expect(response).to redirect_to("I'm a little teapot")
    end
  end

end
