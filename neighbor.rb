EARTH_RADIUS = 6317.009

def normalize_lat(lat)
  if lat > 90
    lat = 90
  elsif lat < -90
    lat = -90
  end
  lat
end

def normalize_lng(lng)
  #raise Exception.new unless lng < 360 and lng > -360
  if lng >= 360
    lng = lng % 360
  elsif lng <= -360
    lng = lng % -360
  end
  if lng > 180
    lng = lng % 180 - 180
  elsif lng < -180
    lng = lng % -180 + 180
  end
  lng
end

def tol_lat(r)
  r/EARTH_RADIUS*180/Math::PI
end

def tol_lng(r, lat)
  r/EARTH_RADIUS/Math.cos(lat/180*Math::PI)*180/Math::PI
end

def range_lat(lat, r)
  t = tol_lat(r)
  [normalize_lat(lat-t), lat, normalize_lat(lat+t)]
end

def range_lng(lng, lat, r)
  t = tol_lng(r, lat)
  [normalize_lng(lng-t), lng, normalize_lng(lng+t)]
end

def neighbor(lat, lng, r=2)
  p = []
  range_lat(lat, r).each do |e1|
    range_lng(lng, lat, r).each do |e2|
      p << [e1, e2]
    end
  end
  p
end



