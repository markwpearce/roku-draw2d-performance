
sub drawLine(testCount as integer, testData as object)
  halfW = m.screenW / 2
  halfH = m.screenH / 2

  x1 = rnd(halfW)
  x2 = rnd(halfW) + halfW
  y1 = rnd(halfH)
  y2 = rnd(halfH) + halfH
  color = getColor()
  m.screen.drawLine(x1, y1, x2, y2, color)
end sub


sub drawRect(testCount as integer, testData as object)
  halfW = m.screenW / 2
  halfH = m.screenH / 2

  x1 = rnd(halfW)
  y1 = rnd(halfH)
  w = rnd(halfW)
  h = rnd(halfH)
  color = getColor()
  m.screen.drawRect(x1, y1, w, h, color)
end sub


sub drawPoint(testCount as integer, testData as object)
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  size = 10
  color = getColor()
  m.screen.drawPoint(x1, y1, size, color)
end sub

sub drawObject(testCount as integer, testData as object)
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, m.testBitmap)
end sub


sub drawRotatedObject(testCount as integer, testData as object)
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  theta = rnd(360)
  m.screen.drawRotatedObject(x1, y1, theta, m.testBitmap)
end sub

sub drawScaledObject(testCount as integer, testData as object)
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  scaleX = 5 * rnd(0)
  scaley = 5 * rnd(0)
  m.screen.drawScaledObject(x1, y1, scaleX, scaleY, m.testBitmap)
end sub

sub createTempBitmap(testCount as integer, testData as object)
  halfW = m.screenW / 2
  halfH = m.screenH / 2
  tempBitmap = CreateObject("roBitmap", {width: halfW, height: halfH, AlphaEnable: true})
  color = getColor()
  tempBitmap.drawRect(10, 10, halfW - 20, halfH - 20, color)

  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, tempBitmap)
end sub

sub createTempBitmapAndRegion(testCount as integer, testData as object)
  halfW = m.screenW / 2
  halfH = m.screenH / 2
  tempBitmap = CreateObject("roBitmap", {width: halfW, height: halfH, AlphaEnable: true})
  tempRegion = CreateObject("roRegion", tempBitmap, 0, 0, halfW, halfH)
  color = getColor()
  tempRegion.drawRect(10, 10, halfW - 20, halfH - 20, color)

  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, tempRegion)
end sub

sub reuseBitmap(testCount as integer, testData as object)
  halfW = m.screenW / 2
  halfH = m.screenH / 2
  if invalid = testData.tempBitmapReuse
    testData.tempBitmapReuse = CreateObject("roBitmap", {width: halfW, height: halfH, AlphaEnable: true})
  else
    testData.tempBitmapReuse.clear(0)
  end if
  color = getColor()
  testData.tempBitmapReuse.drawRect(10, 10, halfW - 20, halfH - 20, color)
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, testData.tempBitmapReuse)
end sub

sub reuseBitmapCreateRegion(testCount as integer, testData as object)
  halfW = m.screenW / 2
  halfH = m.screenH / 2
  if invalid = testData.tempBitmapCreateRegion
    testData.tempBitmapCreateRegion = CreateObject("roBitmap", {width: halfW, height: halfH, AlphaEnable: true})
  else
    testData.tempBitmapCreateRegion.clear(0)
  end if
  tempRegion = CreateObject("roRegion", testData.tempBitmapCreateRegion, 0, 0, halfW, halfH)
  color = getColor()
  tempRegion.drawRect(10, 10, halfW - 20, halfH - 20, color)

  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, tempRegion)
end sub

sub reuseBitmapAndRegion(testCount as integer, testData as object)
  halfW = m.screenW / 2
  halfH = m.screenH / 2
  if invalid = testData.tempBitmapReuseBoth
    testData.tempBitmapReuseBoth = CreateObject("roBitmap", {width: halfW, height: halfH, AlphaEnable: true})
  end if
  if invalid = testData.tempRegionReuse
    testData.tempRegionReuse = CreateObject("roRegion", testData.tempBitmapReuseBoth, 0, 0, halfW, halfH)
  else
    testData.tempRegionReuse.clear(0)
  end if
  color = getColor()
  testData.tempRegionReuse.drawRect(10, 10, halfW - 20, halfH - 20, color)

  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, testData.tempRegionReuse)
end sub


function testCompositorWrapHd(testCount as integer, testData as object)
  return testCompositorWrapMethod(testData, "pkg:/images/hd-image.jpg")
end function

function testCompositorWrapFhd(testCount as integer, testData as object)
  return testCompositorWrapMethod(testData, "pkg:/images/fhd-image.jpg")
end function

function testCompositorWrap4k(testCount as integer, testData as object)
  return testCompositorWrapMethod(testData, "pkg:/images/4k-image.jpg")
end function

function testCompositorSprites(testCount as integer, testData as object)
  if invalid = testData.testCompositorSpritesSetup
    testData.compositor = CreateObject("roCompositor")
    testData.drawBmp = CreateObject("roBitmap", {width: m.screenW, height: m.screenH, AlphaEnable: true})
    if invalid = testData.drawBmp
      return false
    end if
    testData.compositor.SetDrawTo(testData.drawBmp, 0)

    cellRegions = getWalkingSpriteCells(9)
    staticRegion = getWalkingSpriteCells(1)
    spriteCount = m.functionPerfCount
    testData.animatedSprites = []
    testData.staticSprites = []
    for i = 0 to spriteCount / 2
      x = rnd(m.screenW)
      y = rnd(m.screenH)
      z = i
      testData.animatedSprites.push(testData.compositor.NewAnimatedSprite(x, y, cellRegions, z))
    end for
    for i = 0 to spriteCount / 2
      x = rnd(m.screenW)
      y = rnd(m.screenH)
      z = i
      testData.staticSprites.push(testData.compositor.NewSprite(x, y, staticRegion[0], z))
    end for

    testData.testCompositorSpritesSetup = true
  end if
  testData.compositor.animationTick(1)
  moveCompositorSprites(testData.animatedSprites, 2, 0)

  testData.drawBmp.clear(&hFF)
  testData.compositor.DrawAll()
  m.screen.drawObject(0, 0, testData.drawBmp)
end function

function testManualSprites(testCount as integer, testData as object)
  if invalid = testData.testManualSpritesSetup
    testData.drawBmp = CreateObject("roBitmap", {width: m.screenW, height: m.screenH, AlphaEnable: true})
    if invalid = testData.drawBmp
      return false
    end if
    cellRegions = getWalkingSpriteCells(9)
    staticRegion = getWalkingSpriteCells(1)
    spriteCount = m.functionPerfCount
    testData.animatedSprites = []
    testData.staticSprites = []
    for i = 0 to spriteCount / 2
      x = rnd(m.screenW)
      y = rnd(m.screenH)
      testData.animatedSprites.push(createSpriteObject(x, y, cellRegions))
    end for
    for i = 0 to spriteCount / 2
      x = rnd(m.screenW)
      y = rnd(m.screenH)
      testData.staticSprites.push(createSpriteObject(x, y, staticRegion))
    end for
    testData.testManualSpritesSetup = true
  end if

  testData.drawBmp.clear(&hFF)
  for each sprite in testData.animatedSprites
    sprite.activeRegion += 1
    if sprite.activeRegion >= sprite.regions.count()
      sprite.activeRegion = 0
    end if
    moveConstrainSprite(sprite, 2, 0)
    testData.drawBmp.drawObject(sprite.x, sprite.y, sprite.regions[sprite.activeRegion])
  end for
  for each sprite in testData.staticSprites
    testData.drawBmp.drawObject(sprite.x, sprite.y, sprite.regions[sprite.activeRegion])
  end for

  m.screen.drawObject(0, 0, testData.drawBmp)
end function

