require 'spec_helper'
require 'mongoid/bigbang/generator'

describe Mongoid::Bigbang::Generator do

  subject { Mongoid::Bigbang::Generator.instance }

  describe '#id_from_time' do
    let(:bigbang) { Time.parse('18-01-2015 15:53:00 +0000') }

    it 'generates an id for the given time' do
      id = subject.id_from_time(bigbang)
      id.generation_time.should eq bigbang
    end

    context 'when the time is a string' do
      let(:time) { bigbang.to_s }
      it 'generates an id for the given time' do
        id = subject.id_from_time(time)
        id.generation_time.should eq bigbang
      end
    end

    context 'when the time is an integer' do
      let(:time) { bigbang.to_i }
      it 'generates an id for the given time' do
        id = subject.id_from_time(time)
        id.generation_time.should eq bigbang
      end
    end

    context 'when the random part has already been used for that timestamp' do
      let(:secure_random) { SecureRandom }
      it 'generates another random part' do
        secure_random.should_receive(:hex).twice.and_return("63dd436fe9be4ece")
        secure_random.should_receive(:hex).once.and_return("7cfe2c1518f8711b")
        subject.should_receive(:secure_random).exactly(3).times.and_call_original

        # create first ObjectId for this timestamp
        # 1st call - does not enter loop since random 63dd436fe9be4ece doesn't exist yet
        subject.id_from_time(bigbang)

        # create second ObjectId for this timestamp
        # 2nd call - enters loop because we force random 63dd436fe9be4ece to be returned again
        # 3rd call - does not enter loop because it generates a new random 7cfe2c1518f8711b
        subject.id_from_time(bigbang)
      end
    end

    describe '#clean' do
      it 'clears the already used randoms for each timestamp' do
        subject.id_from_time(bigbang)
        subject.used.length.should_not eq 0

        subject.clean
        subject.used.length.should eq 0
      end
    end
  end

end