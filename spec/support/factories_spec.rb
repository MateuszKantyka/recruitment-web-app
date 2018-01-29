require 'rails_helper'

RSpec.describe 'FactoryBot linter' do
  it 'verifies that all FactoryBot factories are valid' do
    FactoryBot.lint
  end
end
