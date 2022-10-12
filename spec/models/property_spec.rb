require 'rails_helper'

RSpec.describe Property, type: :model do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:headline) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:address_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:country) }
  end

  context "Associations" do
    it { should have_many_attached(:images) } 
    it { should have_many(:reviews) } 
  end

  context "money_rails" do
    it { is_expected.to monetize(:price).allow_nil }
  end
end
