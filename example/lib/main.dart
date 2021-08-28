import 'package:flutter/material.dart';
import 'package:oex/models/OEXEngine.dart';
import 'package:oex/oex.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<OEXEngine> engines = [];

  Future<void> getEngines() async {
    final result = await OEX.search();
    setState(() {
      engines = result;
    });
  }

  void start(OEXEngine engine) async {
    Stream output = await engine.start();
    output.listen((out) {print(out);});
    Future.delayed(Duration(milliseconds: 500));
    engine.send("uci");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: engines.length,
        itemBuilder: (context, index) {
          OEXEngine engine = engines[index];
          return ListTile(
            title: Text(engine.name),
            subtitle: Text("${engine.versionCode} / ${engine.enginePath}"),
            onTap: () => start(engine),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getEngines,
        tooltip: 'Search',
        child: Icon(Icons.power_settings_new),
      ),
    );
  }
}
