'*************************************************************
'** Draw2d Performance Benchmark Tool
'*************************************************************

sub main()
  repeat = 10000
  m.drawFpsTarget = 30

  m.testBitmap = CreateObject("roBitmap", "pkg:/images/roku-logo-transparent.png")
  m.screenW = 1280
  m.screenH = 720
  m.maxTestTimeMs = 30000
  fontRegistry = CreateObject("roFontRegistry")
  m.defaultFont = fontRegistry.GetDefaultFont()
  m.screen = CreateObject("roScreen", true, m.screenW, m.screenH)
  m.screen.setAlphaEnable(true)
  m.functionPerfCount = 50
  m.suite = ""
  doFunctionSpeedTests = true
  doDrawTests = true
  doRegionCreationTests = true
  doCompositingTests = true
  printHeaderDetails()

  if doFunctionSpeedTests
    m.suite = "FunctionSpeed"
    runBenchmark("RecursionFunction", recursionFunction, repeat)
    runBenchmark("RecursionSub", recursionSub, repeat)
    runBenchmark("Loop", loop, repeat)
    runBenchmark("LoopFuncCall", loopFuncCall, repeat)
    runBenchmark("LoopFuncCallNoReturn", loopFuncCallNoReturn, repeat)
    runBenchmark("LoopSubCall", loopSubCall, repeat)
    runBenchmark("ClassCreate", classCreate, repeat)
  end if
  if doDrawTests
    m.suite = "Draw"
    repeatsForThisTest = repeat * 10 ' these are fast
    runBenchmark("DrawLine", drawLine, repeatsForThisTest)
    runBenchmark("DrawRect", drawRect, repeatsForThisTest)
    runBenchmark("DrawPoint", drawPoint, repeatsForThisTest)
    m.screen.setAlphaEnable(false)
    runBenchmark("DrawObject (no-Alpha)", drawObject, repeatsForThisTest)
    m.screen.setAlphaEnable(true)
    runBenchmark("DrawObject (with-Alpha)", drawObject, repeatsForThisTest)
    runBenchmark("DrawRotatedObject", drawRotatedObject, repeatsForThisTest)
    runBenchmark("DrawScaledObject", drawScaledObject, repeatsForThisTest)
  end if
  if doRegionCreationTests
    m.suite = "RegionCreation"
    runBenchmark("CreateTempBitmap", createTempBitmap, repeat)
    runBenchmark("ReuseBitmap", reuseBitmap, repeat)
    runBenchmark("CreateTempBitmapAndRegion", createTempBitmapAndRegion, repeat)
    runBenchmark("ReuseBitmapAndRegion", reuseBitmapAndRegion, repeat)
  end if
  if doCompositingTests
    m.suite = "Compositing"
    runBenchmark("CompositorWrap (HD)", testCompositorWrapHd, repeat)
    runBenchmark("CompositorWrap (FHD)", testCompositorWrapFhd, repeat)
    runBenchmark("CompositorWrap (4k)", testCompositorWrap4k, repeat)
    runBenchmark("CompositorSprites", testCompositorSprites, repeat)
    runBenchmark("ManualSprites", testManualSprites, repeat)
  end if
end sub



sub printHeaderDetails()
  appInfo = CreateObject("roAppInfo")
  deviceInfo = CreateObject("roDeviceInfo")
  ? "Roku Draw2d Performance Benchmark Tool - v";appInfo.GetVersion()
  ? deviceInfo.GetModelDisplayName();" (";deviceInfo.GetModelDetails().modelNumber;") ";deviceInfo.GetModelType()
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
  testData = {}
  timeForFrame = 0
  totalLastFrameTime = 0
  totalTime = 0
  testNotSupported = false
  while (i < repeat and totalTime < m.maxTestTimeMs)
    testResult = testFunction(i, testData)
    if testResult <> invalid and not testResult
      testNotSupported = true
      exit while
    end if

    timeForFrame = frameTimer.totalMilliseconds()
    if timeForFrame > msPerSwapTarget or (dynamicallyScale and not firstFrame and opsSinceSwap >= opsPerSwap)

      frameTimer.mark()
      if opsPerSwap < opsSinceSwap and firstFrame
        opsPerSwap = opsSinceSwap
      end if
      firstFrame = false
      drawTextWithBackground(opsSinceSwap.toStr(), m.screenW - 300, m.screenH - 100, 250)
      drawTextWithBackground(m.suite + ":" + benchmarkName, 50, 50, m.screenW - 100)
      m.screen.swapBuffers()
      m.screen.clear(255)
      frameCount++
      swapTime = frameTimer.totalMilliseconds()
      if dynamicallyScale
        totalLastFrameTime = timeForFrame + swapTime
        opsPerSwap = intScaleIfNeeded(opsPerSwap, totalLastFrameTime, msPerSwapTarget)
      end if
      totalSwapTime += swapTime
      frameTimer.mark()
      opsSinceSwap = 0

      totalTime = totalTimer.totalMilliseconds()
    end if
    i += 1
    opsSinceSwap += 1
  end while
  if opsPerSwap < 0
    opsPerSwap = opsSinceSwap
  end if
  if frameCount = 0
    m.screen.swapBuffers()
    frameCount = 1
  end if
  if testNotSupported
    ? benchmarkName;": skipped, not supported"
    return
  end if
  totalTime = totalTimer.totalMilliseconds()
  actualFrameTime = cint(totalTime / frameCount)
  opsPerFrame = cint(i / frameCount)
  opsPerSecond = cint(i / (totalTime / 1000))
  avgSwapTime = cint(totalSwapTime / frameCount)
  m.screen.swapBuffers()
  ? benchmarkName;": ";totalTime;"ms, ";actualFrameTime;"ms per frame";", ";opsPerFrame;" ops per frame";", ";opsPerSecond;" ops per second, ";avgSwapTime;"ms avg swap time, ";min(opsPerSwap, opsPerFrame);" ops per frame to reach target"
end sub

