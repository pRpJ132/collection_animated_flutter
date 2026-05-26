import 'package:example/models/product.dart';
import 'package:example/view/widgets/header.dart';
import 'package:example/view/widgets/product.dart';
import 'package:flutter/material.dart';

final GlobalKey cartKey = GlobalKey();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        cartKey: cartKey,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: products.map(
                  (v) => ProductCard(
                    product: v, 
                    targetKey: cartKey,
                    pageVsync: this
                  ),
                ).toList(),
              ),
            ),
          ],
        )
      ),
    );
  }
}
