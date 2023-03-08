'*************************************************************
'** Draw2d Performance Benchmark Tool

'*************************************************************

sub main()
  repeat = 100000
  m.drawFpsTarget = 30
  m.testBitmap = CreateObject("roBitmap", "pkg:/images/roku-logo-transparent.png")
  m.screenW = 1280
  m.screenH = 720
  m.screen = CreateObject("roScreen", true, m.screenW, m.screenH)
  m.screen.setAlphaEnable(true)
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
end sub



sub runBenchmark(benchmarkName, testFunction, repeat, dynamicallyScale = true)
  i = 0
  msPerSwap = cint(1000 / m.drawFpsTarget)
  frameCount = 0
  totalSwapTime = 0
  m.screen.clear(255)
  frameTimer = CreateObject("roTimeSpan")
  totalTimer = CreateObject("roTimeSpan")
  drawsPerSwap = -1
  framesSinceSwap = 0
  while (i < repeat)
    testFunction()

    timeForFrame = frameTimer.totalMilliseconds()
    if timeForFrame > msPerSwap or (dynamicallyScale and drawsPerSwap > 0 and framesSinceSwap >= drawsPerSwap)

      frameTimer.mark()
      if drawsPerSwap < 0
        drawsPerSwap = framesSinceSwap
      end if

      m.screen.swapBuffers()
      m.screen.clear(255)
      frameCount++
      swapTime = frameTimer.totalMilliseconds()
      if dynamicallyScale
        totalFrameTime = timeForFrame + swapTime
        drawsPerSwap = intScaleIfNeeded(drawsPerSwap, totalFrameTime, msPerSwap, 2 * msPerSwap)
      end if
      totalSwapTime += swapTime
      frameTimer.mark()
      framesSinceSwap = 0
    end if
    i += 1
    framesSinceSwap += 1
  end while
  totalTime = totalTimer.totalMilliseconds()
  actualFrameTime = cint(totalTime / frameCount)
  opsPerFrame = cint(i / frameCount)
  opsPerSecond = cint(i / (totalTime / 1000))
  avgSwapTime = cint(totalSwapTime / frameCount)
  m.screen.swapBuffers()
  ? benchmarkName;": ";totalTime;"ms, ";actualFrameTime;"ms per frame";", ";opsPerFrame;" ops per frame";", ";opsPerSecond;" ops per second, ";avgSwapTime;"ms avg swap time, ";drawsPerSwap;" draws per frame to reach target"
end sub


