require 'spec_helper'

describe Category do
  context "Attributes" do
    it { should validate_presence_of :name }
  end
end
