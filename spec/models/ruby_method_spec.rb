# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RubyMethod, type: :model do
  describe '#validations' do
    it 'ファクトリが有効であること' do
      expect(build(:zip_method_of_array)).to be_valid
    end

    it 'nameが無ければ、レコード作成が無効であること' do
      zip_method_of_array = build(:zip_method_of_array, name: nil)
      zip_method_of_array.valid?
      expect(zip_method_of_array.errors[:name]).to include('を入力してください')
    end
    it '重複したnameが存在するなら、レコード作成が無効であること' do
      create(:zip_method_of_array)
      zip_method_of_array = build(:zip_method_of_array)
      zip_method_of_array.valid?
      expect(zip_method_of_array.errors[:name]).to include('はすでに存在します')
    end
  end
end
