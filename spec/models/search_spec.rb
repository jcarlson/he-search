require 'rails_helper'

RSpec.describe Search, type: :model do
  it { is_expected.to validate_presence_of(:term) }
end
