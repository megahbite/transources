require 'rails_helper'

describe Resource do
  context "Attributes" do
    it "should validate presence of :title" do
      expect(subject).to validate_presence_of :title
    end
    it "should validate presence of :description" do
      expect(subject).to validate_presence_of :description
    end
    it "should validate presence of :address_line_1" do
      expect(subject).to validate_presence_of :address_line_1
    end
    it "should validate presence of :town" do
      expect(subject).to validate_presence_of :town
    end
    it "should validate presence of :country" do
      expect(subject).to validate_presence_of :country
    end

    context "website" do
      let(:resource) { FactoryGirl.create(:resource) }
      it "is invalid with a non-URI" do
        resource.website = "I'm a little teapot"
        expect(resource).to_not be_valid
      end

      it "is invalid with a javascript URI" do
        resource.website = "javascript:alert('XSS attack')"
        expect(resource).to_not be_valid
      end

      it "is valid with a URL" do
        resource.website = "http://google.com"
        expect(resource).to be_valid
      end
    end
  end
end
