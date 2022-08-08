# oex

A Flutter Plugin, which lets you search and interact OEX Chess Engines on Android

🔎 Discover UCI-Engines

🗣️ Interact with UCI-Engines

## Screenshot

![screenshot](https://github.com/mono424/oex/blob/images/screenshot.png?raw=true)

## How to use

### 🚀 Setup

Add the dependency to pubspec.yaml.

```yaml
dependencies:
  [...]
  oex: ^0.1.0
```

and import it.

```dart
import 'package:oex/oex.dart';
```

### 🔎 Discover Engines

```dart
List<OEXEngine> result = await OEX.search();
print(result);
```

### 🗣️ Interact with Engines

```dart
Stream<String> stdout = await engine.start();
stdout.listen((out) {
    print(out);
});

Future.delayed(Duration(milliseconds: 500));
engine.send("uci");
```

## Additional information

This package is used in [WhitePawn](https://whitepawn.app) in production.

Every contribution is very welcome.

Cheers 🥂