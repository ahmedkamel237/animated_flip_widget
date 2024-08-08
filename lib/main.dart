import 'package:animated_flip_widget/animated_flip_widget/animated_flip_controller.dart';
import 'package:animated_flip_widget/animated_flip_widget/page_flip_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AnimatedFlipWidgetDemo(),
    );
  }
}

class AnimatedFlipWidgetDemo extends StatefulWidget {
  const AnimatedFlipWidgetDemo({super.key});

  @override
  State<AnimatedFlipWidgetDemo> createState() => _AnimatedFlipWidgetDemoState();
}

class _AnimatedFlipWidgetDemoState extends State<AnimatedFlipWidgetDemo> {
  final controller = FlipController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              itemCount: 9,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => AnimatedFlipWidget(
                controller: controller,
                firstChild: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                secondChild: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
