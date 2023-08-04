require 'rails_helper'
RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to validate_presence_of(:username) }


  describe 'enums' do
    it 'defines the correct roles' do
      expect(User.roles[:Super_Admin]).to eq('Super_Admin')
      expect(User.roles[:Business_Developer]).to eq('Business_Developer')
      expect(User.roles[:Technical_Manager]).to eq('Technical_Manager')
      expect(User.roles[:Engineer]).to eq('Engineer')
    end
  end
end
