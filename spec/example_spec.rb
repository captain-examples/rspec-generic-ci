# frozen_string_literal: true

describe 'Example' do
  it 'is a me, a mario' do
    expect('mario').to_not eq('luigi')
  end

  it 'is a flake' do
    expect(rand).to be > 0.1
  end
end
