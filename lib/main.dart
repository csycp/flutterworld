import 'package:flutter/material.dart';
import 'package:flutterworld/screens/home_screen.dart';

void main() {
  runApp(const App());
}

// Root Widget
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffe7626c),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                color: Color(0xff232b55),
              ),
            ),
            cardColor: const Color(0xfff4eddb)),
        home: const HomeScreen());
  }
}
