
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





function testCompositorWrap(testCount as integer, testData as object)
  if invalid = testData.testCompositorWrapSetup
    screen = m.screen
    black = &hFF'RGBA
    testData.compositor = CreateObject("roCompositor")
    testData.compositor.SetDrawTo(screen, black)
    offset = 100

    bigbm = CreateObject("roBitmap", "pkg:/images/4k-image.jpg")
    region = CreateObject("roRegion", bigbm, offset, offset, m.screenW - 2 * offset, m.screenH - 2 * offset)
    region.SetWrap(True)

    testData.view_sprites = []
    testData.view_sprites.push(testData.compositor.NewSprite(100, 100, region))

    testData.testCompositorWrapSetup = true
  end if
  offset = 100
  rectOutline = 4
  m.screen.drawRect(offset - rectOutline, offset - rectOutline, m.screenW - 2 * offset + 2 * rectOutline, m.screenH - 2 * offset + 2 * rectOutline, &hFF0000FF)
  offsetCompositorSprites(testData.compositor, testData.view_sprites, 1, 1)
end function


