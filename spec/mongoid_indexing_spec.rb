require 'spec_helper'

describe Mongoid::Indexing do
  it 'should be loaded' do
    expect(Mongoid::Indexing).to_not be_nil
  end
end