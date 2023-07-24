# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RubyModule, type: :model do
  it 'ファクトリが有効であること' do
    expect(build(:array_module)).to be_valid
  end

  describe 'validations' do
    subject(:array_module) { build(:array_module) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:ruby_methods).dependent(:destroy)}
  end
end
