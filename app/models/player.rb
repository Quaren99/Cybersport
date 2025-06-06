class Player < ApplicationRecord
  has_many :members, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true
  validates :realname, presence: true
end
