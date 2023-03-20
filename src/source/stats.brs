function getStatTypes()
  stats = [
    {field: "name", headerText: "Benchmark Name"},
    {field: "didRun", headerText: "Test Ran"},
    {field: "totalTime", headerText: "Total time (ms)"},
    {field: "actualFrameTime", headerText: "Avg Time per Frame (ms)"},
    {field: "opsPerFrame", headerText: "Avg Ops per Frame"},
    {field: "opsPerSecond", headerText: "Avg Ops per Second"},
    {field: "avgSwapTime", headerText: "Avg Swap time per Frame (ms)"},
    {field: "avgOpsToReachTarget", headerText: "Ops per Frame to reach FPS"}
  ]
  return stats
end function


function buildBenchmarkResult(name as string, didRun = false as boolean, totalTime = -1 as integer, frameCount = -1 as integer, actualOps = -1 as integer, totalSwapTime = -1 as integer, opsPerSwap = -1 as integer)
  actualFrameTime = cint(totalTime / frameCount)
  opsPerFrame = cint(actualOps / frameCount)
  opsPerSecond = cint(actualOps / (totalTime / 1000))
  avgSwapTime = cint(totalSwapTime / frameCount)
  avgOpsToReachTarget = min(opsPerSwap, opsPerFrame)
  result = {
    name: name,
    didRun: didRun,
    totalTime: totalTime
    frameCount: frameCount,
    actualOps: actualOps,
    totalSwapTime: totalSwapTime,
    actualFrameTime: actualFrameTime,
    opsPerFrame: opsPerFrame,
    opsPerSecond: opsPerSecond,
    avgSwapTime: avgSwapTime,
    avgOpsToReachTarget: avgOpsToReachTarget
  }
  return result
end function


function getCSVHeaderLine() as string
  statTypes = getStatTypes()
  i = 0
  line = ""
  for each stat in statTypes
    line += stat.headerText
    if i < statTypes.count() - 1
      line += ","
    end if
    i++
  end for
  return line
end function

function getCSVResultLine(result) as string
  statTypes = getStatTypes()
  i = 0
  line = ""
  for each stat in statTypes
    line += result[stat.field].toStr()
    if i < statTypes.count() - 1
      line += ","
    end if
    i++
  end for
  return line
end function