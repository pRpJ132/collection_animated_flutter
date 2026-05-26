import 'dart:math';

import 'package:collection_animated/collection_animated.dart';
import 'package:example/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final GlobalKey targetKey;
  final TickerProvider pageVsync;
  const ProductCard({
    super.key,
    required this.product,
    required this.targetKey,
    required this.pageVsync,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey buttonKey = GlobalKey();
    final Size size = Size(100, 250);
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(32)
      ),
      width: size.width * 2,
      height: size.height * 1.1,
      child: Column(
        children: [
          Image.asset(
            key: buttonKey,
            width: size.width * 0.9,
            height: size.height * 0.6,
            product.image
          ),
          StarScore(
            score: product.mark,
            star: Star(
                fillColor: Color(0xFFFFE868),
                emptyColor: Color(0xFFE8E8E8)
            ),
          ),
          Text(
            product.name
          ),
          Text(
            r"$" + product.price.toString()
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 50, 124, 251)
              ),
              onPressed: () => CollectionAnimated(
                vsync: pageVsync, 
                buttonKey: buttonKey, 
                targetKey: targetKey, 
                flyWidget: Image.asset(
                  width: size.width * 0.9,
                  height: size.height * 0.6,
                  product.image
                ),
                launchAngle: 0,
                backOffset: 0,
                sideOffset: 0,
                arcHeight: Random().nextBool() ? -(45 + Random().nextInt(55 - 45 + 1)).toDouble() : (45 + Random().nextInt(55 - 45 + 1)).toDouble(),
                leftShift: -45,
                topShift: -75,
                scalePhase1: CollectionAnimatedValues(begin: 1.0, end: 1.0),
                scalePhase2: CollectionAnimatedValues(begin: 1.0, end: 0.08),
                launchDuration: Duration(milliseconds: 0),
                scaleAnimated: true,
                opacityAnimated: true,
              ).startAnimation(), 
              child: Text(
                "Add cart",
                style: TextStyle(
                  color: Colors.white
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}