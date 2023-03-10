'*************************************************************
'** Draw2d Performance Benchmark Tool

'*************************************************************

sub main()
  repeat = 100000
  m.drawFpsTarget = 30
  appInfo = CreateObject("roAppInfo")
  m.testBitmap = CreateObject("roBitmap", "pkg:/images/roku-logo-transparent.png")
  m.screenW = 1280
  m.screenH = 720
  fontRegistry = CreateObject("roFontRegistry")
  m.defaultFont = fontRegistry.GetDefaultFont()
  m.screen = CreateObject("roScreen", true, m.screenW, m.screenH)
  m.screen.setAlphaEnable(true)
  ? "Roku Draw2d Performance Benchmark Tool - v";appInfo.GetVersion()

  runBenchmark("Recursion", recursion, repeat / 10)
  runBenchmark("DrawLine", drawLine, repeat)
  runBenchmark("DrawRect", drawRect, repeat)
  runBenchmark("DrawPoint", drawPoint, repeat)
  m.screen.setAlphaEnable(false)
  runBenchmark("DrawObject (no-Alpha)", drawObject, repeat)
  m.screen.setAlphaEnable(true)
  runBenchmark("DrawObject (with-Alpha)", drawObject, repeat)
  runBenchmark("DrawRotatedObject", drawRotatedObject, repeat)
  runBenchmark("DrawScaledObject", drawScaledObject, repeat)
  runBenchmark("CreateTempBitmap", createTempBitmap, repeat / 10)
  runBenchmark("ReuseBitmap", reuseBitmap, repeat / 10)
  runBenchmark("CreateTempBitmapAndRegion", createTempBitmapAndRegion, repeat / 10)
  runBenchmark("ReuseBitmapAndRegion", reuseBitmapAndRegion, repeat / 10)
  runBenchmark("CompositorWrap", testCompositorWrap, repeat / 10)
end sub



sub runBenchmark(benchmarkName, testFunction, repeat, dynamicallyScale = true)
  i = 0
  msPerSwapTarget = cint(1000 / m.drawFpsTarget)
  frameCount = 0
  totalSwapTime = 0
  m.screen.clear(255)
  frameTimer = CreateObject("roTimeSpan")
  totalTimer = CreateObject("roTimeSpan")
  opsPerSwap = 100
  firstFrame = true
  opsSinceSwap = 0
  while (i < repeat)
    testFunction()

    timeForFrame = frameTimer.totalMilliseconds()
    if timeForFrame > msPerSwapTarget or (dynamicallyScale and not firstFrame and opsSinceSwap >= opsPerSwap)

      frameTimer.mark()
      if opsPerSwap < opsSinceSwap and firstFrame
        opsPerSwap = opsSinceSwap
      end if
      firstFrame = false
      drawTextWithBackground(opsSinceSwap.toStr(), m.screenW - 300, m.screenH - 100, 250)
      drawTextWithBackground(benchmarkName, 50, 50, m.screenW - 100)
      m.screen.swapBuffers()
      m.screen.clear(255)
      frameCount++
      swapTime = frameTimer.totalMilliseconds()
      if dynamicallyScale
        totalFrameTime = timeForFrame + swapTime
        opsPerSwap = intScaleIfNeeded(opsPerSwap, totalFrameTime, msPerSwapTarget, 1.5 * msPerSwapTarget)
      end if
      totalSwapTime += swapTime
      frameTimer.mark()
      opsSinceSwap = 0
    end if
    i += 1
    opsSinceSwap += 1
  end while
  if opsPerSwap < 0
    opsPerSwap = opsSinceSwap
  end if
  totalTime = totalTimer.totalMilliseconds()
  actualFrameTime = cint(totalTime / frameCount)
  opsPerFrame = cint(i / frameCount)
  opsPerSecond = cint(i / (totalTime / 1000))
  avgSwapTime = cint(totalSwapTime / frameCount)
  m.screen.swapBuffers()
  ? benchmarkName;": ";totalTime;"ms, ";actualFrameTime;"ms per frame";", ";opsPerFrame;" ops per frame";", ";opsPerSecond;" ops per second, ";avgSwapTime;"ms avg swap time, ";min(opsPerSwap, opsPerFrame);" ops per frame to reach target"
end sub

