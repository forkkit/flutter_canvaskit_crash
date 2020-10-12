# canvaskit_crash_rive

Example code demonstrating CanvasKit crash.

## Getting Started

Run the app with the CanvasKit backend:
```
flutter run --profile --dart-define=FLUTTER_WEB_USE_SKIA=true -d chrome
```

- Open the dev tools (happens much more rarely without the dev tools open).
- Press the refresh button on the bottom right and wait for the load cycles (it repeats it a bunch of times to accelerate the crash).
- Wait for the hourglass to return to a reload button.
- Repeat pressing reload, waiting for hourglass, until it crahses (usually takes 2-3 tries on my machine).
- When it breaks you'll see the Canvas is mis-shapen/mis-sized and there'll be an error in the console.
- Eventually another error will occur which will freeze execution completely.