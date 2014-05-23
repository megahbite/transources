require 'spec_helper'

describe CommentsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin_user) { FactoryGirl.create(:admin) }
  let(:spam_user) { FactoryGirl.create(:user, name: "viagra-test-123") }

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

      it "marks as spam any spam comments" do
        sign_in spam_user
        post :create, { resource_id: resource.id, comment: valid_attributes }

        expect(assigns(:comment).spam).to be_true
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      sign_in admin_user
      comment
      expect {
        delete :destroy, { resource_id: comment.resource.to_param, :id => comment.to_param}
      }.to change(Comment, :count).by(-1)
    end

    context "regular user" do
      it "can destroy their own comment" do
        sign_in user
        comment.user = user
        comment.save!
        expect {
          delete :destroy, { resource_id: comment.resource.to_param, id: comment.to_param }
        }.to change(Comment, :count).by(-1)
      end

      it "can't destroy someone else's comment" do
        sign_in user
        comment.user = FactoryGirl.create(:user)
        comment.save!
        delete :destroy, { resource_id: comment.resource.to_param, id: comment.to_param }
        expect(flash[:error]).to_not be_nil
        expect(flash[:error]).to include "not authorized"
      end
    end
  end

  describe "GET ham" do
    before(:each) do
      request.env["HTTP_REFERER"] = "I'm a little teapot"
    end
    it "changes the comments status to not spam" do
      sign_in admin_user
      comment.spam = true
      comment.save!
      get :ham, {ids: [comment.id]}
      comment.reload
      expect(comment.spam).to be_false
    end

    context "regular user" do
      it "can't mark a comment as not spam" do
        sign_in user
        get :ham, {ids: [comment.id]}
        expect(flash[:error]).to_not be_nil
        expect(flash[:error]).to include "not authorized"
      end
    end
  end

  describe "GET spam" do
    before(:each) do
      request.env["HTTP_REFERER"] = "I'm a little teapot"
    end
    it "changes the comments status to spam" do
      sign_in admin_user
      comment.spam = false
      comment.save!
      get :spam, {ids: [comment.id]}
      comment.reload
      expect(comment.spam).to be_true
    end

    context "regular user" do
      it "can't mark a comment as spam" do
        sign_in user
        get :spam, {ids: [comment.id]}
        expect(flash[:error]).to_not be_nil
        expect(flash[:error]).to include "not authorized"
      end
    end
  end

end
