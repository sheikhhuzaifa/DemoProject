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


end
