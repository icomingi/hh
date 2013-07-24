require 'test/unit'
require './geohash'

class TestGeohash < Test::Unit::TestCase
  def test_encode
    assert_equal(Geohash.encode(0,0), 'kpbpbpbpbp')  
  end
  def test_decode
    sjmm = Geohash.decode('sjmm')
    assert_in_delta(-30.49804, sjmm[0], 0.0001)
    assert_in_delta(7.55859, sjmm[1], 0.0001)
  end
  def test_input_failure
    assert_raise(Geohash::OutofRangeError.new) {Geohash.encode(300, 20)}
    assert_raise(ArgumentError) {Geohash.decode('b11aij')}
  end
  def test_accuracy
    a = [60, -120]
    a_s = Geohash.encode(*a, 12)
    a_d = Geohash.decode(a_s)
    assert_in_delta(60.0, a_d[0], 0.000001)
    assert_in_delta(-120, a_d[1], 0.000001)
  end
end
