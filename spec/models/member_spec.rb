require "rails_helper"

RSpec.describe Member, type: :model do
  it { should belong_to(:player) }
  it { should belong_to(:team) }
  it { should validate_presence_of(:joined) }
end
