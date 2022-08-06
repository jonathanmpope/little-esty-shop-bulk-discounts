require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'validations' do
    it { should validate_inclusion_of(:percent).in_range(1..100) }
    it { should validate_presence_of :quantity_threshold }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
  end

end 