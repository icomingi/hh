module Geohash

#Two basic functions
#encode
#cut the region in half, get a note, iterate through until hitting certain precision, turn all notes into a string
#decode
#Look through the region, step by step according to the string and recover the information

BASE32 = "0123456789bcdefghjkmnpqrstuvwxyz"

def self.encode(lat, lng, precision=10)
  raise OutofRangeError.new, "Latitude should be between -90 and 90.\nPlease check your lat input." unless -90 <= lat and lat <= 90
  raise OutofRangeError.new, "Longitude should be between -180 and 180.\nPlease check your lng input." unless -180 <= lng and lng <= 180
  encoded_s = ""
  encoded_bin = []
  lat_range = [-90.0, 90.0] #Should use float, my mistake was to use integer and the result was that the precision is very limited.
  lng_range = [-180.0, 180.0]
  precision = 5 * precision
  i = 0
  while i < precision
    if i.even? #remember to add "?" to get a boolean back, my mistake was to use ".even" without "?"
      lng_mid = (lng_range[0] + lng_range[1]) / 2
      if lng < lng_mid
        encoded_bin << 0
        lng_range[1] = lng_mid
      else
        encoded_bin << 1
        lng_range[0] = lng_mid
      end
    else
      lat_mid = (lat_range[0] + lat_range[1]) / 2
      if lat < lat_mid
        encoded_bin << 1
        lat_range[1] = lat_mid
      else
        encoded_bin << 0
        lat_range[0] = lat_mid
      end
    end
    i += 1
  end
  while encoded_bin.length > 0
    n = encoded_bin.shift(5).reverse #I wanted to use the algorith in the following line to convert a series of binaries back to decimals, but the way index increases is the exact opposite way each binary number represents.
    n = n.each_with_index.map {|e, index| e*2**index} #each_with_index
    encoded_s << BASE32[n.reduce(:+)] #reduce is a great way to collect 
  end
  return encoded_s
end

class OutofRangeError < Exception
end

def self.decode(s)
  #raise error if input string contains illegal characters
  raise ArgumentError.new, "Argument should be string." unless s.is_a? String
  raise OutofRangeError.new, "Encoded string should not contain 'ailo'." unless /^[^ailo]+$/.match(s)
  s_a = s.split(//) #Use empty regex to split everything up
  s_a.map! {|e| BASE32.index(e).to_s(2).rjust(5, '0').split(//)}  #use rjust() to make sure 5 digits will be returned, if not, irregular number of digits will be found and no way to convert it back to original binary representation.
  s_a.flatten!
  s_a.map! {|e| e.to_i}
  #puts s_a.join('')
  lat_range = [-90.0, 90.0]
  lng_range = [-180.0, 180.0]
  lng_a = []
  lat_a = []
  i = 0
  while s_a.length > 0
    if i.even?
      lng_a << s_a.shift  #use shift(), the counterpart of pop()
    else
      lat_a << s_a.shift
    end
    i += 1
  end
  while lng_a.length > 0
    e = lng_a.shift
    e.even? ? lng_range[1] = (lng_range[0] + lng_range[1])/2 : lng_range[0] = (lng_range[0] + lng_range[1])/2
  end
  while lat_a.length > 0
    e = lat_a.shift
    e.even? ? lat_range[0] = (lat_range[0] + lat_range[1])/2 : lat_range[1] = (lat_range[0] + lat_range[1])/2
  end
  return (lat_range[0] + lat_range[1])/2, (lng_range[0] + lng_range[1])/2
end

end
