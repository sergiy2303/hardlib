require 'rails_helper'

describe 'simple test' do
  it 'should pass test' do
    expect(true).to be_truthy
  end

  it 'should pass test too' do
    expect(false).to be_falsey
  end
end