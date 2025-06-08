require "rails_helper"

RSpec.describe Player, type: :model do
  it { should validate_presence_of(:nickname) }
  it { should validate_uniqueness_of(:nickname) }
end
