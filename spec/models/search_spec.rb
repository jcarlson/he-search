require 'rails_helper'

RSpec.describe Search, type: :model do
  it { is_expected.to validate_presence_of(:term) }

  describe '.trending' do
    let!(:expected_results) do
      [
         described_class.create(term: 'foo', created_at: 2.minutes.ago),
         described_class.create(term: 'bar', created_at: 4.minutes.ago),
         described_class.create(term: 'baz', created_at: 6.minutes.ago)
      ]
    end

    it 'orders by count, then creation date' do
      expect(described_class.trending).to eq(expected_results)
    end

    context 'when a search term is repeated' do
      before do
        described_class.create(term: 'foo', created_at: 10.minutes.ago)
      end

      it 'returns only the newest instance' do
        expect(described_class.trending).to eq(expected_results)
      end
    end
  end
end
