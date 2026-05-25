library;

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CollectionAnimated {
  final TickerProvider vsync;

  final GlobalKey buttonKey;

  final GlobalKey targetKey;

  final Widget flyWidget;

  final double launchAngle;
  final double backOffset;
  final double sideOffset;
  final double arcHeight;

  final Duration launchDuration;
  final Duration flyDuration;

  final bool scaleAnimated;
  final bool opacityAnimated;
  
  final VoidCallback? onCompleted;

  const CollectionAnimated({
    required this.vsync,
    required this.buttonKey,
    required this.targetKey,
    required this.flyWidget,
    this.launchAngle = 270,
    this.backOffset = 80,
    this.sideOffset = 60,
    this.arcHeight = 180,
    this.launchDuration = const Duration(milliseconds: 350),
    this.flyDuration = const Duration(milliseconds: 600),
    this.scaleAnimated = false,
    this.opacityAnimated = false,
    this.onCompleted,
  });

  void startAnimation() {
    final context = buttonKey.currentContext!;

    final radians = launchAngle * pi / 180;
    final dirX = cos(radians);
    final dirY = sin(radians);
    final perpX = -dirY;
    final perpY = dirX;

    final overlay = Overlay.of(context);

    final buttonBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
    final targetBox = targetKey.currentContext!.findRenderObject() as RenderBox;

    final start = buttonBox.localToGlobal(buttonBox.size.center(Offset.zero));
    final end = targetBox.localToGlobal(targetBox.size.center(Offset.zero));

    final peak = Offset(
      start.dx + dirX * backOffset + perpX * sideOffset,
      start.dy + dirY * backOffset + perpY * sideOffset,
    );

    final AnimationController launchController = AnimationController(vsync: vsync, duration: launchDuration);
    final AnimationController flyController = AnimationController(vsync: vsync, duration: flyDuration);

    final launchCurve = CurvedAnimation(parent: launchController, curve: Curves.easeOut);
    final flyCurve = CurvedAnimation(parent: flyController, curve: Curves.easeInOut);

    final posNotifier = ValueNotifier<Offset>(start);
    final scaleNotifier = ValueNotifier<double>(1.0);
    final opacityNotifier = ValueNotifier<double>(1.0);

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return ValueListenableBuilder<Offset>(
          valueListenable: posNotifier,
          builder: (context, pos, _) {
            return Positioned(
              left: pos.dx - 20,
              top: pos.dy - 20,
              child: ValueListenableBuilder<double>(
                valueListenable: scaleNotifier,
                builder: (context, scale, _) {
                  return Transform.scale(
                    scale: scaleAnimated ? scale : 1.0,
                    child: IgnorePointer(child: ValueListenableBuilder<double>(
                      valueListenable: opacityNotifier,
                      builder: (context, opacityNotifierValue, _) {
                        return Opacity(
                          opacity: opacityAnimated ? opacityNotifierValue : 1.0,
                          child: flyWidget
                        );
                      }
                    )),
                  );
                }
              ),
            );
          },
        );
      },
    );

    overlay.insert(overlayEntry);

    void cleanup() {
      overlayEntry.remove();
      posNotifier.dispose();
      scaleNotifier.dispose();
      onCompleted?.call();
    }

    void updateFlyPosition(double t) {
      final dx = end.dx - peak.dx;
      final dy = end.dy - peak.dy;
      final len = sqrt(dx * dx + dy * dy);

      double arcPerpX = 0;
      double arcPerpY = 0;
      if (len > 0) {
        arcPerpX = -dy / len;
        arcPerpY = dx / len;
      }

      final arc = sin(t * pi) * arcHeight;

      posNotifier.value = Offset(
        lerpDouble(peak.dx, end.dx, t)! + arcPerpX * arc,
        lerpDouble(peak.dy, end.dy, t)! + arcPerpY * arc,
      );
      scaleNotifier.value = lerpDouble(1.0, 0.4, t)!;
      opacityNotifier.value = lerpDouble(1.0, 0.2, t)!;
    }

    launchController.addListener(() {
      final t = launchCurve.value;
      posNotifier.value = Offset(
        lerpDouble(start.dx, peak.dx, t)!,
        lerpDouble(start.dy, peak.dy, t)!,
      );
      scaleNotifier.value = lerpDouble(0.4, 1.0, t)!;
      opacityNotifier.value = lerpDouble(0.1, 1.0, t)!;
    });

    launchController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        launchController.dispose();
        flyController.forward();
      }
    });

    flyController.addListener(() {
      updateFlyPosition(flyCurve.value);
    });

    flyController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        flyController.dispose();
        cleanup();
      }
    });

    launchController.forward();
  }
}