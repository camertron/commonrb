require './commonrb'

CommonRb.define(['./text_splitter', './text_joiner']) do |mod, s, j|
  mod.exports = {
    TextWrangler: mod.define_class do
      attach s: s, j: j

      def self.do_your_thing
        splitter = s.TextSplitter.new
        joiner = j.TextJoiner.new

        arr = splitter.split('foo bar')
        joiner.join(arr)
        # puts "Text split is: #{arr.inspect}"
        # puts "Text joined is: #{joiner.join(arr)}"
      end
    end
  }
end
