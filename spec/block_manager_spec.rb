require 'rspec'
require_relative '../src/block'
require_relative '../src/block_manager'
require_relative '../src/time_manager'

class StubTimeProvider
  attr_accessor :actual_time
  def initialize
    self.actual_time = 0
  end
end

describe 'Block manager spec' do

  it 'should call move on all blocks on every update' do
    a_stub_time_provider = StubTimeProvider.new
    a_time_manager = TimeManager.new(a_stub_time_provider)
    a_block_manager = BlockManager.new(20, 20, 300, 300, 1000, a_time_manager)
    a_block = Block.new(20, 20, 20, a_block_manager)
    another_block = Block.new(40, 20, 20, a_block_manager)
    block_at_bottom = Block.new(40, 300, 20, a_block_manager)

    a_stub_time_provider.actual_time = 600
    a_time_manager.update
    a_stub_time_provider.actual_time = 800
    a_time_manager.update

    expect(a_block.y).to eq(20)
    expect(another_block.y).to eq(20)
    expect(block_at_bottom.y).to eq(300)

    a_stub_time_provider.actual_time = 1100

    a_time_manager.update

    expect(a_block.y).to eq(40)
    expect(another_block.y).to eq(40)
    expect(block_at_bottom.y).to eq(300)
  end

  it 'a block manager should move all the blocks which are moving' do
    a_stub_time_provider = StubTimeProvider.new
    a_time_manager = TimeManager.new(a_stub_time_provider)
    a_block_manager = BlockManager.new(20, 20, 300, 300, 1000, a_time_manager)
    a_block = Block.new(20, 20, 20, a_block_manager)
    another_block = Block.new(60, 20, 20, a_block_manager)
    block_at_bottom = Block.new(40, 300, 20, a_block_manager)

    expect(a_block.y).to eq(20)
    expect(another_block.y).to eq(20)
    expect(block_at_bottom.y).to eq(300)

    expect(a_block.x).to eq(20)
    expect(another_block.x).to eq(60)
    expect(block_at_bottom.x).to eq(40)

    a_block_manager.move_right
    a_block_manager.move_right

  end
end