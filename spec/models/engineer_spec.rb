require 'rails_helper'

RSpec.describe Engineer, type: :model do
  describe "validations" do
    it "is valid with a valid email" do
      engineer = build(:engineer)
      expect(engineer).to be_valid
    end

    it "is invalid without an email" do
      engineer = build(:engineer, email: nil)
      expect(engineer).to_not be_valid
    end
  end

  describe "associations" do
    it { should belong_to(:phase) }
  end
end
