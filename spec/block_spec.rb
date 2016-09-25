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

describe 'Block tests' do
  it 'a block should understand x, y, and size' do
    a_stub_time_provider = StubTimeProvider.new
    a_time_manager = TimeManager.new(a_stub_time_provider)
    a_block_manager = BlockManager.new(20, 20, 300, 300, 1000, a_time_manager)
    a_block = Block.new(20, 20, 20, a_block_manager)

    expect(a_block.x).to eq 20
    expect(a_block.y).to eq 20
    expect(a_block.size).to eq 20
  end

  it 'a block should be move down when go is called' do
    a_stub_time_provider = StubTimeProvider.new
    a_time_manager = TimeManager.new(a_stub_time_provider)
    a_block_manager = BlockManager.new(20, 20, 300, 300, 1000, a_time_manager)
    a_block = Block.new(20, 20, 20, a_block_manager)

    a_block.go
    a_block.go

    expect(a_block.y).to eq 60
  end

  it 'a block should not move down if he reached the bottom' do
    a_stub_time_provider = StubTimeProvider.new
    a_time_manager = TimeManager.new(a_stub_time_provider)
    a_block_manager = BlockManager.new(20, 20, 300, 300, 1000, a_time_manager)
    a_block = Block.new(20, 280, 20, a_block_manager)

    a_block.go

    expect(a_block.y).to eq 300

    a_block.go
    a_block.go

    expect(a_block.y).to eq 300
  end

  it 'a block should not move if theres a block below him' do
    a_stub_time_provider = StubTimeProvider.new
    a_time_manager = TimeManager.new(a_stub_time_provider)
    a_block_manager = BlockManager.new(20, 20, 300, 300, 1000, a_time_manager)
    another_block = Block.new(20, 300, 20, a_block_manager)
    a_block = Block.new(20, 260, 20, a_block_manager)

    another_block.go
    a_block.go
    a_block.go
    a_block.go

    expect(another_block.y).to eq 300
    expect(a_block.y).to eq 280
  end

  it 'a block should be able to move to sides' do
    a_stub_time_provider = StubTimeProvider.new
    a_time_manager = TimeManager.new(a_stub_time_provider)
    a_block_manager = BlockManager.new(20, 20, 300, 300, 1000, a_time_manager)
    a_block = Block.new(20, 280, 20, a_block_manager)

    a_block.move_right

    expect(a_block.x).to eq 40

    a_block.move_left

    expect(a_block.x).to eq 20
  end

  it 'a block should not be able to move out of bound' do
    a_stub_time_provider = StubTimeProvider.new
    a_time_manager = TimeManager.new(a_stub_time_provider)
    a_block_manager = BlockManager.new(20, 20, 300, 300, 1000, a_time_manager)
    a_block = Block.new(20, 280, 20, a_block_manager)

    a_block.move_left

    expect(a_block.x).to eq 20

    a_block.move_left

    expect(a_block.x).to eq 20
  end

  it 'a block should not be able to move if theres another block' do
    a_stub_time_provider = StubTimeProvider.new
    a_time_manager = TimeManager.new(a_stub_time_provider)
    a_block_manager = BlockManager.new(20, 20, 300, 300, 1000, a_time_manager)
    a_block = Block.new(20, 280, 20, a_block_manager)
    another_block = Block.new(40, 280, 20, a_block_manager)

    a_block.move_right # no effect

    expect(a_block.x).to eq 20
    expect(another_block.x).to eq 40

    a_block.move_right # no effect
    another_block.move_right
    a_block.move_right

    expect(a_block.x).to eq 40
    expect(another_block.x).to eq 60
  end
end