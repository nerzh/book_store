require 'rails_helper'

describe FormForCheckout do

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:task) }
    it { should have_many(:uploads) }
  end

  context 'validations' do
    it { should validate_length_of(:name).is_at_most(220) }
    it { should validate_presence_of(:task) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
  end

  context 'set name' do
    let(:comment) { create(:comment, name: 'test name') }

    it 'return set name' do
      expect(comment.name).to eq('test name')
    end
  end

end