require 'rails_helper'

RSpec.describe BasketItem, type: :model do
  it { should belong_to(:basket) }
  it { should belong_to(:product) }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
end
