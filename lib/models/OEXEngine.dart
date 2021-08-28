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
  late Process _process;

  get outStream => _outStreamController.stream;
  get errStream => _errStreamController.stream;

  OEXEngine(this.packageName, this.name, this.versionCode, this.fileName, this.enginePath);

  Future<Stream<String>> start() async {
    _outStreamController = new StreamController<String>();
    _errStreamController = new StreamController<String>();
    _process = await Process.start(this.enginePath, []);
    _process.stdout.listen(_stdout);
    _process.stderr.listen(_stderr);
    return _outStreamController.stream;
  }

  void send(String message) {
    _process.stdin.add(utf8.encode(message + "\n"));
  }

  void _stdout(List<int> input) {
    _outStreamController.add(utf8.decode(input));
  }

  void _stderr(List<int> input) {
    _errStreamController.add(utf8.decode(input));
  }
}