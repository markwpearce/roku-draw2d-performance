function getColor(r = 255, g = 255, b = 255, a = 255)
  red% = rnd(r)
  green% = rnd(g)
  blue% = rnd(b)
  color% = (red% << 24) + (green% << 16) + (blue% << 8) + a
  return color%
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



sub drawTextWithBackground(text, x, y, width)
  height = 50
  offset = 5
  m.screen.drawRect(x - offset, y - offset, width + 2 * offset, height, &hFF)
  m.screen.drawText(text, x, y, &hFFFFFFFF, m.defaultFont)
end sub