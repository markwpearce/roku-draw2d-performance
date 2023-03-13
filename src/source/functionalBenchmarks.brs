
sub recursionFunction(testCount as integer, testData as object)
  subtractOneUntilZero(m.functionPerfCount)
  drawTextWithBackground("Tests: " + testCount.toStr(), 50, 100, 300)
end sub

sub recursionSub(testCount as integer, testData as object)
  subtractOneUntilZeroSub(m.functionPerfCount)
  drawTextWithBackground("Tests: " + testCount.toStr(), 50, 100, 300)
end sub

sub loop(testCount as integer, testData as object)
  num = 0
  for i = 0 to m.functionPerfCount
    num += i
  end for
  drawTextWithBackground("Tests: " + testCount.toStr(), 50, 100, 300)
end sub


sub loopFuncCall(testCount as integer, testData as object)
  for i = 0 to m.functionPerfCount
    getOne()
  end for
  drawTextWithBackground("Tests: " + testCount.toStr(), 50, 100, 300)
end sub

sub loopFuncCallNoReturn(testCount as integer, testData as object)
  for i = 0 to m.functionPerfCount
    noopfn()
  end for
  drawTextWithBackground("Tests: " + testCount.toStr(), 50, 100, 300)
end sub


sub loopSubCall(testCount as integer, testData as object)
  for i = 0 to m.functionPerfCount
    noop()
  end for
  drawTextWithBackground("Tests: " + testCount.toStr(), 50, 100, 300)
end sub

sub classCreate(testCount as integer, testData as object)
  for i = 0 to m.functionPerfCount
    klass = getClass()
  end for
  drawTextWithBackground("Tests: " + testCount.toStr(), 50, 100, 300)
end sub



