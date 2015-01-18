require 'singleton'
require 'time'
require 'securerandom'
require 'moped'

module Mongoid
  module Bigbang
    class Generator

      include Singleton

      attr_reader :used

      def initialize()
        clean
      end

      def clean
        @used = {}
      end

      def id_from_time(time)
        time = unix_time(time)
        string = time.to_s(16) + random_for(time)
        BSON::ObjectId.from_string(string)
      end

      private
      def unix_time(time)
        case time
        when Time
          time.to_i
        when Integer
          time
        when String
          Time.parse(time).to_i
        else
          raise ArgumentError
        end
      end

      def random_for(time)
        random = secure_random
        while already_used?(time, random)
          random = secure_random
        end
        used[time] ? used[time].push(random) : used[time] = [random]
        random
      end

      def secure_random
        SecureRandom.hex(8)
      end

      def already_used?(time, random)
        used[time] && used[time].include?(random)
      end

    end
  end
end