require './commonrb'

CommonRb.define do |mod|
  mod.exports = {
    TextJoiner: Class.new do
      def join(arr)
        arr.join(' ')
      end
    end
  }
end
