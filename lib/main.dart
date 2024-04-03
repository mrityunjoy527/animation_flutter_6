import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Color getRandomColor() => Color(0xFF000000 + math.Random().nextInt(0x00FFFFFF));

class _MyAppState extends State<MyApp> {
  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true),
      home: Scaffold(
        body: Center(
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            tween: ColorTween(
              begin: _color,
              end: getRandomColor(),
            ),
            onEnd: () {
              setState(() {
                _color = getRandomColor();
              });
            },
            child: ClipPath(
              clipper: const CircleClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                color: Colors.red,
              ),
            ),
            builder: (context, color, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color!,
                  BlendMode.srcATop,
                ),
                child: child!,
              );
            },
          ),
        ),
      ),
    );
  }
}
