
sub recursion()
  if invalid = m.recursionTests
    m.recursionTests = 0
  end if

  subTract1(50)
  m.recursionTests += 1
  drawTextWithBackground("Tests: " + m.recursionTests.toStr(), 50, 100, 300)

end sub



function subTract1(num)
  if num > 0
    return subtract1(num - 1)
  end if
  return num + 1
end function


sub drawLine()
  halfW = m.screenW / 2
  halfH = m.screenH / 2

  x1 = rnd(halfW)
  x2 = rnd(halfW) + halfW
  y1 = rnd(halfH)
  y2 = rnd(halfH) + halfH
  color = getColor()
  m.screen.drawLine(x1, y1, x2, y2, color)
end sub


sub drawRect()
  halfW = m.screenW / 2
  halfH = m.screenH / 2

  x1 = rnd(halfW)
  y1 = rnd(halfH)
  w = rnd(halfW)
  h = rnd(halfH)
  color = getColor()
  m.screen.drawRect(x1, y1, w, h, color)
end sub



sub drawPoint()
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  size = 10
  color = getColor()
  m.screen.drawPoint(x1, y1, size, color)
end sub

sub drawObject()
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, m.testBitmap)
end sub


sub drawRotatedObject()
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  theta = rnd(360)
  m.screen.drawRotatedObject(x1, y1, theta, m.testBitmap)
end sub

sub drawScaledObject()
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  scaleX = 5 * rnd(0)
  scaley = 5 * rnd(0)
  m.screen.drawScaledObject(x1, y1, scaleX, scaleY, m.testBitmap)
end sub

sub createTempBitmap()
  halfW = m.screenW / 2
  halfH = m.screenH / 2
  tempBitmap = CreateObject("roBitmap", {width: halfW, height: halfH, AlphaEnable: true})
  color = getColor()
  tempBitmap.drawRect(10, 10, halfW - 20, halfH - 20, color)

  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, tempBitmap)
end sub

sub createTempBitmapAndRegion()
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

sub reuseBitmap()
  halfW = m.screenW / 2
  halfH = m.screenH / 2
  if invalid = m.tempBitmapReuse
    m.tempBitmapReuse = CreateObject("roBitmap", {width: halfW, height: halfH, AlphaEnable: true})
  else
    m.tempBitmapReuse.clear(0)
  end if
  color = getColor()
  m.tempBitmapReuse.drawRect(10, 10, halfW - 20, halfH - 20, color)
  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, m.tempBitmapReuse)
end sub

sub reuseBitmapCreateRegion()
  halfW = m.screenW / 2
  halfH = m.screenH / 2
  if invalid = m.tempBitmapCreateRegion
    m.tempBitmapCreateRegion = CreateObject("roBitmap", {width: halfW, height: halfH, AlphaEnable: true})
  else
    m.tempBitmapCreateRegion.clear(0)
  end if
  tempRegion = CreateObject("roRegion", m.tempBitmapCreateRegion, 0, 0, halfW, halfH)
  color = getColor()
  tempRegion.drawRect(10, 10, halfW - 20, halfH - 20, color)

  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, tempRegion)
end sub

sub reuseBitmapAndRegion()
  halfW = m.screenW / 2
  halfH = m.screenH / 2
  if invalid = m.tempBitmapReuseBoth
    m.tempBitmapReuseBoth = CreateObject("roBitmap", {width: halfW, height: halfH, AlphaEnable: true})
  end if
  if invalid = m.tempRegionReuse
    m.tempRegionReuse = CreateObject("roRegion", m.tempBitmapReuseBoth, 0, 0, halfW, halfH)
  else
    m.tempRegionReuse.clear(0)
  end if
  color = getColor()
  m.tempRegionReuse.drawRect(10, 10, halfW - 20, halfH - 20, color)

  x1 = rnd(m.screenW)
  y1 = rnd(m.screenH)
  m.screen.drawObject(x1, y1, m.tempRegionReuse)
end sub





function testCompositorWrap()
  if invalid = m.testCompositorWrapSetup
    screen = m.screen
    black = &hFF'RGBA
    m.compositor = CreateObject("roCompositor")
    m.compositor.SetDrawTo(screen, black)
    offset = 100

    bigbm = CreateObject("roBitmap", "pkg:/images/4k-image.jpg")
    region = CreateObject("roRegion", bigbm, offset, offset, m.screenW - 2 * offset, m.screenH - 2 * offset)
    region.SetWrap(True)

    m.view_sprites = []
    m.view_sprites.push(m.compositor.NewSprite(100, 100, region))

    m.testCompositorWrapSetup = true
  end if

  offsetCompositorSprites(m.view_sprites, 1, 1)
end function


function offsetCompositorSprites(view_sprites, xd, yd)
  offset = 100
  rectOutline = 4
  m.screen.drawRect(offset - rectOutline, offset - rectOutline, m.screenW - 2 * offset + 2 * rectOutline, m.screenH - 2 * offset + 2 * rectOutline, &hFF0000FF)
  for each sprite in view_sprites
    sprite.OffsetRegion(xd, yd, 0, 0)
  end for
  m.compositor.draw()
end function