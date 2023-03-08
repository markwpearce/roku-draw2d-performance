# Roku Draw2d Performance Benchmarking App

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
