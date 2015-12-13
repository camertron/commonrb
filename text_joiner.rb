require './commonrb'

CommonRb.define do |mod|
  mod.exports = {
    TextJoiner: mod.define_class do
      def join(arr)
        arr.join(' ')
      end
    end
  }
end
