import 'dart:math';
import 'package:collection_animated/collection_animated.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with TickerProviderStateMixin {
  final GlobalKey cartKey = GlobalKey();
  final GlobalKey buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collection Animation"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.shopping_cart,
              key: cartKey,
              size: 32,
            ),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          key: buttonKey,
          onPressed: () {
            CollectionAnimated(
              vsync: this,
              buttonKey: buttonKey,
              targetKey: cartKey,
              flyWidget: const Icon(Icons.favorite, color: Colors.red, size: 40),
              launchAngle: (0 + Random().nextInt(360 - 0 + 1)).toDouble(),
              backOffset: (25 + Random().nextInt(85 - 25 + 1)).toDouble(),
              sideOffset: (50 + Random().nextInt(145 - 50 + 1)).toDouble(),
              arcHeight: Random().nextBool() ? -(45 + Random().nextInt(155 - 45 + 1)).toDouble() : (45 + Random().nextInt(155 - 45 + 1)).toDouble(),
              scaleAnimated: true,
              opacityAnimated: true,
            ).startAnimation();
          },
          child: const Text("Добавить"),
        ),
      ),
    );
  }
}