import 'package:flutter/material.dart';
import 'package:flutterworld/screens/home_screen.dart';

void main() {
  runApp(const App());
}

// Root Widget
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
