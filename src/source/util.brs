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


function intScaleIfNeeded(value, testVal, target, buffer = 0.5)
  if testVal = 0
    value = cint(scaleUp(value))
    return value
  end if
  factor = target / testVal
  lowerBound = target '* (1 - buffer)
  upperBound = target * (1 + buffer)
  if testVal > upperBound
    value = cint(scaleDown(value, factor))
  else if testVal < lowerBound
    value = cint(scaleUp(value, factor))
  end if
  return value
end function


sub drawTextLinesWithBackground(textLines, x, y, width, lineHeight, font)

  numLines = textLines.count()
  offset = 5
  height = numLines * lineHeight + 2 * offset
  m.screen.drawRect(x - offset, y - offset, width + 2 * offset, height, &hFF)
  i = 0
  for each line in textLines
    m.screen.drawText(line, x, y + i * lineHeight, &hFFFFFFFF, font)
    i++
  end for

end sub


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


function testCompositorWrapMethod(testData as object, bmpName as string)
  offset = 100
  if invalid = testData.setupComplete
    testData.compositor = CreateObject("roCompositor")
    testData.compositor.SetDrawTo(m.screen, &hFF)
    testData.view_sprites = []
    bigBmp = CreateObject("roBitmap", bmpName)
    if invalid = bigBmp
      return false
    end if
    region = CreateObject("roRegion", bigBmp, offset, offset, m.screenW - 2 * offset, m.screenH - 2 * offset)
    region.SetWrap(True)
    testData.view_sprites.push(testData.compositor.NewSprite(offset, offset, region))
    testData.setupComplete = true
  end if
  rectOutline = 4
  m.screen.drawRect(offset - rectOutline, offset - rectOutline, m.screenW - 2 * offset + 2 * rectOutline, m.screenH - 2 * offset + 2 * rectOutline, &hFF0000FF)
  offsetCompositorSprites(testData.view_sprites, 1, 1)
  testData.compositor.draw()
  return true
end function

sub offsetCompositorSprites(view_sprites, xd, yd)
  for each sprite in view_sprites
    sprite.OffsetRegion(xd, yd, 0, 0)
  end for
end sub

sub moveCompositorSprites(view_sprites, xd, yd)
  for each sprite in view_sprites
    moveConstrainSprite(sprite, xd, yd)
  end for
end sub

sub moveConstrainSprite(sprite, xd, yd)
  currentX = sprite.GetX()
  currentY = sprite.GetY()

  x = currentX + xd
  y = currentY + yd

  if x > m.screenW
    x = 0
  else if x < 0
    x = m.screenW
  end if
  if y > m.screenH
    y = 0
  else if y < 0
    y = m.screenH
  end if
  sprite.moveTo(x, y)
end sub


function getWalkingSpriteCells(numCells as integer)
  walkingBmp = CreateObject("roBitmap", "pkg:/images/walkingsprite.png")

  cellW = 144
  cellH = 180

  return getBitmapCells(walkingBmp, 0, 0, numCells, cellW, cellH)
end function

function getBitmapCells(bmp, x, y, numCells, cellW, cellH)
  cellRegions = []
  for i = 0 to numCells - 1
    region = CreateObject("roRegion", bmp, x + i * cellW, y, cellW, cellH)
    cellRegions.push(region)
  end for
  return cellRegions
end function


function createSpriteObject(x, y, cellRegions)
  return {
    x: x,
    y: y,
    regions: cellRegions,
    activeRegion: 0,
    getX: function()
      return m.x
    end function,
    getY: function()
      return m.y
    end function,
    moveTo: function(a, b)
      m.x = a
      m.y = b
    end function,
    color: getColor()
  }
end function