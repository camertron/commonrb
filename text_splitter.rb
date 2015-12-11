require './commonrb'

CommonRb.define do |mod|
  mod.exports = {
    TextSplitter: mod.define_class do
      def split(text)
        text.split
      end
    end
  }
end
