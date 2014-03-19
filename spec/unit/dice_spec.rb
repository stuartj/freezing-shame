require File.expand_path(File.join(File.dirname(__FILE__), '..', '/spec_helper'))
require 'dice'

describe Dice do

  let(:dice) { Dice.new }

  context 'create' do

    it 'should create with empty feats and rolls arrays' do
      expect(dice.feats).to be_empty
      expect(dice.rolls).to be_empty
    end

  end

  context '#reset' do

    it 'should clear any existing rolls array' do
      dice.rolls = [1]
      dice.reset
      expect(dice.rolls).to be_empty
    end

    it 'should clear any existing feats array' do
      dice.feats = [1]
      dice.reset
      expect(dice.feats).to be_empty
    end

  end

end
