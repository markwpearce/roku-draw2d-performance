

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