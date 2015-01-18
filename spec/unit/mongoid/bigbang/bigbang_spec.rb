require 'spec_helper'
require 'mongoid/bigbang'

describe Mongoid::Bigbang do

  subject { Mongoid::Bigbang }

  let(:generator) { Mongoid::Bigbang::Generator.instance }
  let(:time) { '18-01-2015 15:53:00 +0000' }

  describe '.id_from_time' do
    it 'calls the corresponding method on the generator' do
      generator.should_receive(:id_from_time)
      subject.id_from_time(time)
    end
  end

  describe '.clean' do
    it 'calls the corresponding method on the generator' do
      generator.should_receive(:clean)
      subject.clean
    end
  end

end