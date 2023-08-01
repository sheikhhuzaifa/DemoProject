require 'rails_helper'

RSpec.describe Lead, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      lead = build(:lead)
      expect(lead).to be_valid
    end

    it 'is not valid without a project_name' do
      lead = build(:lead, project_name: nil)
      expect(lead).not_to be_valid
    end

    it 'is not valid without a client_name' do
      lead = build(:lead, client_name: nil)
      expect(lead).not_to be_valid
    end
  end
end
