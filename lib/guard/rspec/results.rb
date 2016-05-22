module Guard
  class RSpec < Plugin
    class Results
      class InvalidData < RuntimeError
      end

      attr_reader :summary
      attr_reader :failed_paths

      def initialize(filename)
        prepare_summary(filename)
      end
      
      private
      
      def prepare_summary(filename)
        lines = File.readlines(filename) rescue nil
        if lines.nil?
          @summary = 'No results file found'
          @failed_paths = []
          return
        end
        if lines.empty? || lines.first.empty?
          dump = lines.inspect
          fail InvalidData, "Invalid results in: #{filename},"\
            " lines:\n#{dump}\n"
        end
        @summary = lines.first.chomp
        @failed_paths = lines[1..11].map(&:chomp).compact
      end
    end
  end
end
