# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:array_module) { FactoryBot.create(:array_module) }
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    driven_by(:rack_test)
  end

  it 'モジュールを登録することができる' do
    login_as(admin_user)
    visit new_ruby_module_path
    fill_in 'モジュール名', with: 'File'
    click_on '登録する'
    expect(page).to have_content 'Ruby module was successfully created.'
  end
end
