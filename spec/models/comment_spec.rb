require 'rails_helper'

describe Comment do
  context "Attributes" do
    let(:comment) { FactoryGirl.create(:comment) }
    it "to be valid with valid attributes" do
      expect(comment).to be_valid
    end

    it "should validate presence of :resource_id" do
      expect(subject).to validate_presence_of :resource_id
    end
  end
end
