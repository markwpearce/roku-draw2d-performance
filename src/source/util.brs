function getColor()
  red% = rnd(256)
  green% = rnd(256)
  blue% = rnd(256)
  color% = (red% << 24) + (green% << 16) + (blue% << 8) + 255
  return color% + 256
end function

function max(a, b)
  if a > b
    return a
  end if
  return b
end function

function min(a, b)
  if a < b
    return a
  end if
  return b
end function


function scaleDown(value, factor = 0.9)
  if value <= 1
    return value
  end if
  return min(factor * value, value - 1)
end function


function scaleUp(value, factor = 1.1)
  return max(factor * value, value + 1)
end function


function intScaleIfNeeded(value, testVal, lowerBound, upperBound)
  if testVal > upperBound
    value = cint(scaleDown(value))
  else if testVal < lowerBound
    value = cint(scaleUp(value))
  end if
  return value
end function