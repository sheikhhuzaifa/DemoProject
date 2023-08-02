require 'rails_helper'

RSpec.describe Phase, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      phase = build(:phase)
      expect(phase).to be_valid
    end

    it 'is not valid without a phase_type' do
      phase = build(:phase, phase_type: nil)
      expect(phase).not_to be_valid
    end

    it 'is not valid without a start_date' do
      phase = build(:phase, start_date: nil)
      expect(phase).not_to be_valid
    end

    it 'is not valid without a due_date' do
      phase = build(:phase, due_date: nil)
      expect(phase).not_to be_valid
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      phase = build(:phase, start_date: Date.today, due_date: Date.tomorrow)
      expect(phase).to be_valid
    end

    it 'is not valid when start_date is greater than due_date' do
      phase = build(:phase, start_date: Date.tomorrow, due_date: Date.today)
      expect(phase).not_to be_valid
      expect(phase.errors[:start_date]).to include("must be less than Due date")
    end
  end

  describe 'associations' do
    it { should belong_to(:lead).with_foreign_key(:lead_id) }
    it { should belong_to(:user).with_foreign_key(:assignee_id) }
    it { should have_many(:engineers).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end


end
