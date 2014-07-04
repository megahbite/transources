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
  end
end
