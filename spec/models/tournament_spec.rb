require "rails_helper"

RSpec.describe Tournament, type: :model do
  it { should have_many(:participants).dependent(:destroy) }
  it { should have_many(:teams).through(:participants) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:prizepool) }
  it { should validate_numericality_of(:prizepool).only_integer.is_greater_than(0) }
end
