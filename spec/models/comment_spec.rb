require 'spec_helper'

describe Comment do
  context "Attributes" do
    let(:comment) { FactoryGirl.create(:comment) }
    it "should be valid with valid attributes" do
      expect(comment).to be_valid
    end

    it { should validate_presence_of :resource_id }
  end
end
