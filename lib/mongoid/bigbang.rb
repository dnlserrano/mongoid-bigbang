require 'mongoid/bigbang/version'
require 'mongoid/bigbang/generator'

module Mongoid
  module Bigbang

    def self.id_from_time(time)
      Mongoid::Bigbang::Generator.instance.id_from_time(time)
    end

    def self.clean
      Mongoid::Bigbang::Generator.instance.clean
    end

  end
end
