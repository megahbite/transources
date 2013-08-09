require 'spec_helper'

describe CommentsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin_user) { FactoryGirl.create(:admin) }

  let(:resource) { FactoryGirl.create(:resource) }

  let(:comment) { 
    c = FactoryGirl.create(:comment) 
    c.resource = resource
    c.save!
    c
  }
  
  let(:valid_attributes) {
    a = FactoryGirl.attributes_for(:comment)
    a.merge!({ anonymous: '0' })
  }

  describe "POST 'create'" do
    describe "with valid params" do
      it "creates a new Comment" do
        sign_in user
        expect {
          post :create, { resource_id: resource.id, comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        sign_in user
        post :create, { resource_id: resource.id, comment: valid_attributes }
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) { sign_in admin_user }
    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete :destroy, { resource_id: 1, :id => comment.to_param}
      }.to change(Comment, :count).by(-1)
    end
  end

end
