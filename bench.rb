require './commonrb'

require 'benchmark/ips'

class TextSplitter
  def split(str)
    str.split
  end
end

class TextJoiner
  def join(arr)
    arr.join(' ')
  end
end

class TextWrangler
  def self.do_your_thing
    splitter = TextSplitter.new
    joiner = TextJoiner.new

    arr = splitter.split('foo bar')
    joiner.join(arr)
    # puts "Text split is: #{arr.inspect}"
    # puts "Text joined is: #{joiner.join(arr)}"
  end
end

Benchmark.ips do |x|
  CommonRb.require(['./text_wrangler']) do |w|
    x.report('commonrb') do
      w.TextWrangler.do_your_thing
    end
  end

  x.report('plain ruby') do
    TextWrangler.do_your_thing
  end

  x.compare!
end
