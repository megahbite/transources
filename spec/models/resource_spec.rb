require 'spec_helper'

describe Resource do
  context "Attributes" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :category }
    it { should validate_presence_of :address_line_1 }
    it { should validate_presence_of :town }
    it { should validate_presence_of :country }
  end
end
