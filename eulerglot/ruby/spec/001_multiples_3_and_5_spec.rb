require_relative '../lib/001_multiples_3_and_5'

describe Multiples3And5 do
  describe '#sum_under/1' do
    context 'under 10' do
      subject { described_class.sum_under(10) }
      it      { is_expected.to eq(23) }
    end

    context 'under 10000' do
      subject { described_class.sum_under(1000) }
      it      { is_expected.to eq(233168) }
    end
  end
end
