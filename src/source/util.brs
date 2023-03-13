function getColor(r = 255 as integer, g = 255 as integer, b = 255 as integer, a = 255 as integer) as integer
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
  factor = max(0.9, factor)
  return min(factor * value, value - 1)
end function


function scaleUp(value, factor = 1.1)
  factor = min(1.1, factor)
  return max(factor * value, value + 1)
end function


function intScaleIfNeeded(value, testVal, target, buffer = 0.25)
  factor = target / testVal
  lowerBound = target * (1 - buffer)
  upperBound = target * (1 + buffer)
  if testVal > upperBound
    value = cint(scaleDown(value, factor))
  else if testVal < lowerBound
    value = cint(scaleUp(value, factor))
  end if
  return value
end function



sub drawTextWithBackground(text, x, y, width)
  height = 50
  offset = 5
  m.screen.drawRect(x - offset, y - offset, width + 2 * offset, height, &hFF)
  m.screen.drawText(text, x, y, &hFFFFFFFF, m.defaultFont)
end sub



function subtractOneUntilZero(num)
  if num > 0
    return subtractOneUntilZero(num - 1)
  end if
  return num + 1
end function

function subtractOneUntilZeroSub(num)
  if num > 0
    subtractOneUntilZeroSub(num - 1)
  end if
end function


sub noop()
  i = 1
end sub

function noopfn()
  i = 1
end function

function getOne()
  return 1
end function

function getClass()
  klass = {
    name: "SomeKlass"
    add: sub (a)
      m.value = m.value + a
    end sub
    value: 0
  }
  return klass
end function

function offsetCompositorSprites(compositor, view_sprites, xd, yd)
  for each sprite in view_sprites
    sprite.OffsetRegion(xd, yd, 0, 0)
  end for
  compositor.draw()
end function