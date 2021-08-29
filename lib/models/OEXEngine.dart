import 'dart:async';
import 'dart:convert';
import 'dart:io';

class OEXEngine {
  final String name;
  final int versionCode;
  final String packageName;
  final String fileName;
  final String enginePath;
  late StreamController<String> _outStreamController;
  late StreamController<String> _errStreamController;
  late Stream<String> _outStream;
  late Stream<String> _errStream;
  late Process _process;
  bool _isRunning = false;

  bool get isRunning => _isRunning;
  Stream<String> get outStream => _outStream;
  Stream<String> get errStream => _errStream;

  OEXEngine(this.packageName, this.name, this.versionCode, this.fileName, this.enginePath);

  Future<Stream<String>> start() async {
    if (_isRunning) return outStream;
    _outStreamController = new StreamController<String>();
    _errStreamController = new StreamController<String>();
    _process = await Process.start(this.enginePath, []);
    _process.stdout.listen(_stdout);
    _process.stderr.listen(_stderr);
    _isRunning = true;

    _outStream = _outStreamController.stream.asBroadcastStream();
    _errStream = _errStreamController.stream.asBroadcastStream();

    return _outStreamController.stream;
  }

  void stop() {
    _outStreamController.close();
    _errStreamController.close();
    _process.kill();
    _isRunning = false;
  }

  void send(String message) {
    if (!_isRunning) return;
    _process.stdin.add(utf8.encode(message + "\n"));
  }

  void _stdout(List<int> input) {
    if (!_isRunning) return;
    String text = utf8.decode(input);
    for (String line in text.split("\n")) {
      _outStreamController.add(line);
    }
  }

  void _stderr(List<int> input) {
    if (!_isRunning) return;
    String text = utf8.decode(input);
    for (String line in text.split("\n")) {
      _errStreamController.add(line);
    }
  }
}