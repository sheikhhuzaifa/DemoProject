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

  describe 'associations' do
    it { should belong_to(:user).with_foreign_key(:bd_id) }
    it { should have_many(:phases).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one(:project).dependent(:destroy) }
  end

  describe 'scopes' do
    it 'sorts records by client name' do
      lead1 = create(:lead, client_name: 'Client C')
      lead2 = create(:lead, client_name: 'Client A')
      lead3 = create(:lead, client_name: 'Client B')

      sorted_leads = Lead.sort_by_client

      expect(sorted_leads).to eq([lead2, lead3, lead1])
    end
  end
end
