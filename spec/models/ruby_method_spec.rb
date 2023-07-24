require 'rails_helper'

RSpec.describe RubyMethod, type: :model do
  describe '#validations' do
    it 'ファクトリが有効であること' do
      expect(build(:zip_method)).to be_valid
    end

    it 'nameが無ければ、レコード作成が無効であること' do
      zip_method = build(:zip_method, name: nil)
      zip_method.valid?
      expect(zip_method.errors[:name]).to include("can't be blank")
    end
    #
    it '重複したnameが存在するなら、レコード作成が無効であること' do
      create(:zip_method)
      zip_method = build(:zip_method)
      zip_method.valid?
      expect(zip_method.errors[:name]).to include("has already been taken")
    end
  end
end
