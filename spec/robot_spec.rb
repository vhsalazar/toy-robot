# frozen_string_literal: true

require_relative '../lib/robot'
describe Robot do
  subject { described_class.new }

  context('Place') do
    context('given invalid arguments throws an exception') do
      it 'when direction is invalid' do
        expect { subject.place(0, 0, :qwerty) }.to raise_error ArgumentError
      end
      it 'when position X is invalid' do
        expect { subject.place(0, -1, :north) }.to raise_error RangeError
      end

      it 'when position Y is invalid' do
        expect { subject.place(0, -1, :north) }.to raise_error RangeError
      end
    end
  end

  context "If it hasn't been placed" do
    it "can't move to north" do
      subject.move
      expect(subject.position).to eq([nil, nil])
    end
    it "can't  move to east" do
      subject.right
      subject.move
      expect(subject.position).to eq([nil, nil])
    end
    it "can't move to south" do
      2.times { subject.right }
      subject.move
      expect(subject.position).to eq([nil, nil])
    end
    it "can't move to west" do
      subject.left
      subject.move
      expect(subject.position).to eq([nil, nil])
    end
  end

  context "If it's been placed" do
    before(:each) do
      subject.place(1, 1, :north)
    end

    it "can report" do
      expect{ subject.report } .to output("1,1,NORTH\n").to_stdout
    end

    it 'should face to north by default' do
      expect(subject.direction).to eq(:north)
    end

    it 'should face :east when rotate to right' do
      expect(subject.right).to eq(:east)
    end

    it 'should face :west when rotate to left' do
      expect(subject.left).to eq(:west)
    end

    it 'can face to south' do
      subject.right
      subject.right
      expect(subject.direction).to eq(:south)
    end

    it "should face to its original direction if it's rotated 4 times to the right" do
      4.times { subject.right }
      expect(subject.direction).to eq(:north)
    end
    
    it "should face to its original direction if it's rotated 4 times to the left" do
      4.times { subject.right }
      expect(subject.direction).to eq(:north)
    end

    it 'can move to north' do
      subject.move
      expect(subject.position).to eq([1, 2])
    end

    it 'can move to east' do
      subject.right
      subject.move
      expect(subject.position).to eq([2, 1])
    end
    it 'can move to south' do
      2.times { subject.right }
      subject.move
      expect(subject.position).to eq([1, 0])
    end
    it 'can move to west' do
      subject.left
      subject.move
      expect(subject.position).to eq([0, 1])
    end

    context 'Boundaries' do
      it "can't be moved out of the boundaries [north]" do
        10.times { subject.move }
        expect(subject.position).to eq([1, 4])
      end
      it "can't be moved out of the boundaries [south]" do
        subject.right
        subject.right
        10.times { subject.move }
        expect(subject.position).to eq([1, 0])
      end
      it "can't be moved out of the boundaries [east]" do
        subject.left
        10.times { subject.move }
        expect(subject.position).to eq([0, 1])
      end
      it "can't be moved out of the boundaries [west]" do
        subject.right
        10.times { subject.move }
        expect(subject.position).to eq([4, 1])
      end
    end
  end
end
