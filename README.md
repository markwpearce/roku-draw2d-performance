# Roku Draw2d Performance Benchmarking App

Benchmarking App for Roku that runs through a series of visual tests for the Roku.

![Screenshot](./screenshot.jpg)

During each test, the test name will appear in the upper right corner, and the current number of operations per frame is displayed in the bottom right corner.

This app will dynamically scale the amount of draw operations to try to match 30 frames per second.

The complete results are printed to the console, in CSV format

Here's the results for a Roku Ultra:

```
Roku Draw2d Performance Benchmark Tool - v0.4.1
Roku Ultra (4802CA) STB
Screen Size: 1280x720, Framerate Target: 30fps, Max Test Time (ms): 30000
Benchmark Name,Test Ran,Total time (ms),Avg Time per Frame (ms),Avg Ops per Frame,Avg Ops per Second,Avg Swap time per Frame (ms),Ops per Frame to reach FPS
RecursionFunction,true,1799,37,204,5559,3,204
RecursionSub,true,1498,36,238,6676,0,238
Loop,true,1005,36,357,9950,0,357
LoopFuncCall,true,1301,35,270,7686,0,268
LoopFuncCallNoReturn,true,1321,36,270,7570,0,266
LoopSubCall,true,1319,36,270,7582,0,266
ClassCreate,true,3366,35,103,2971,0,103
DrawLine,true,23269,52,224,4298,38,160
DrawRect,true,6372,42,667,15694,19,667
DrawPoint,true,3157,35,1099,31676,0,1097
DrawObject (no-Alpha),true,5815,55,952,17197,36,827
DrawObject (with-Alpha),true,20390,58,282,4904,51,232
DrawRotatedObject,true,25663,49,190,3897,35,190
DrawScaledObject,true,30012,47,117,2494,38,117
CreateTempBitmap,true,9209,35,38,1086,0,38
ReuseBitmap,true,8594,36,41,1164,0,41
CreateTempBitmapAndRegion,true,9178,35,38,1090,0,38
ReuseBitmapAndRegion,true,8746,36,41,1143,0,41
CompositorWrap (HD),true,15735,51,33,636,45,30
CompositorWrap (FHD),true,14667,52,35,682,44,31
CompositorWrap (4k),true,17119,52,30,584,45,27
CompositorSprites,true,30046,45,13,291,0,13
ManualSprites,true,30045,45,13,287,0,13
```

In Table Form:

| Benchmark Name            | Test Ran | Total time (ms) | Avg Time per Frame (ms) | Avg Ops per Frame | Avg Ops per Second | Avg Swap time per Frame (ms) | Ops per Frame to reach FPS |
| ------------------------- | -------- | --------------- | ----------------------- | ----------------- | ------------------ | ---------------------------- | -------------------------- |
| RecursionFunction         | true     | 1799            | 37                      | 204               | 5559               | 3                            | 204                        |
| RecursionSub              | true     | 1498            | 36                      | 238               | 6676               | 0                            | 238                        |
| Loop                      | true     | 1005            | 36                      | 357               | 9950               | 0                            | 357                        |
| LoopFuncCall              | true     | 1301            | 35                      | 270               | 7686               | 0                            | 268                        |
| LoopFuncCallNoReturn      | true     | 1321            | 36                      | 270               | 7570               | 0                            | 266                        |
| LoopSubCall               | true     | 1319            | 36                      | 270               | 7582               | 0                            | 266                        |
| ClassCreate               | true     | 3366            | 35                      | 103               | 2971               | 0                            | 103                        |
| DrawLine                  | true     | 23269           | 52                      | 224               | 4298               | 38                           | 160                        |
| DrawRect                  | true     | 6372            | 42                      | 667               | 15694              | 19                           | 667                        |
| DrawPoint                 | true     | 3157            | 35                      | 1099              | 31676              | 0                            | 1097                       |
| DrawObject (no-Alpha)     | true     | 5815            | 55                      | 952               | 17197              | 36                           | 827                        |
| DrawObject (with-Alpha)   | true     | 20390           | 58                      | 282               | 4904               | 51                           | 232                        |
| DrawRotatedObject         | true     | 25663           | 49                      | 190               | 3897               | 35                           | 190                        |
| DrawScaledObject          | true     | 30012           | 47                      | 117               | 2494               | 38                           | 117                        |
| CreateTempBitmap          | true     | 9209            | 35                      | 38                | 1086               | 0                            | 38                         |
| ReuseBitmap               | true     | 8594            | 36                      | 41                | 1164               | 0                            | 41                         |
| CreateTempBitmapAndRegion | true     | 9178            | 35                      | 38                | 1090               | 0                            | 38                         |
| ReuseBitmapAndRegion      | true     | 8746            | 36                      | 41                | 1143               | 0                            | 41                         |
| CompositorWrap (HD)       | true     | 15735           | 51                      | 33                | 636                | 45                           | 30                         |
| CompositorWrap (FHD)      | true     | 14667           | 52                      | 35                | 682                | 44                           | 31                         |
| CompositorWrap (4k)       | true     | 17119           | 52                      | 30                | 584                | 45                           | 27                         |
| CompositorSprites         | true     | 30046           | 45                      | 13                | 291                | 0                            | 13                         |
| ManualSprites             | true     | 30045           | 45                      | 13                | 287                | 0                            | 13                         |

## Install

```
npm install
```

## Build

```
npm run build
```

This will create the file `./out/roku-draw2d-performance.zip`, that can be sideloaded on a Roku.

## Running from VSCode

1. Run debug configuration `BrightScript Debug: Launch`, and input appropriate details each time you debug,

or,

2. Create a `.env` file at the root of the project. It should look like this:

```
ROKU_USERNAME=rokudev
ROKU_PASSWORD=<password for you roku>
ROKU_HOST=<ip address of your roku>
```

and run debug configuration `BrightScript Debug: Launch from ENV`
