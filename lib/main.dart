import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// We track if the animation is playing by whether or not the controller is
  /// running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard _riveArtboard;
  RiveAnimationController _controller;
  bool _loading = false;

  Future<void> _reload(int times) async {
    setState(() {
      _loading = true;
    });
    // setState(() => _riveArtboard = null);
    for (int i = 0; i < times; i++) {
      var data = await rootBundle.load('assets/distinctly_rive.riv');
      var file = RiveFile();
      var success = file.import(data);
      if (success) {
        var artboard = file.mainArtboard;
        artboard.addController(
          _controller = SimpleAnimation('Untitled 1'),
        );
        setState(() => _riveArtboard = artboard);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _reload(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : Rive(artboard: _riveArtboard),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loading ? null : () => _reload(100),
        child: Icon(_loading ? Icons.hourglass_bottom_outlined : Icons.refresh),
      ),
    );
  }
}
