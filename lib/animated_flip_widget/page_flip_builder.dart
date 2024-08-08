import 'package:animated_flip_widget/animated_flip_widget/animated_flip_builder.dart';
import 'package:animated_flip_widget/animated_flip_widget/animated_flip_controller.dart';
import 'package:flutter/material.dart';

class AnimatedFlipWidget extends StatelessWidget {
  final pageFlipKey = GlobalKey<_PageFlipBuilderState>();
  final Widget firstChild;
  final Widget secondChild;
  final FlipController? controller;


  void flip() {
    pageFlipKey.currentState?.flip();
  }
  static AnimatedFlipWidget? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<AnimatedFlipWidget>();
  }

  AnimatedFlipWidget(
      {super.key, required this.firstChild, required this.secondChild, this.controller,});

  @override
  Widget build(BuildContext context) {
    return PageFlipBuilder(
      key: pageFlipKey,
      controller: controller,
      frontBuilder: (_) => FirstFlipWidget(
        onFlip: flip,
        child: firstChild,
      ),
      backBuilder: (_) => SecondFlipWidget(
        onFlip: flip,
        child: secondChild,
      ),
    );
  }
}



class PageFlipBuilder extends StatefulWidget {
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  final FlipController? controller;


  const PageFlipBuilder(
      {super.key, required this.frontBuilder, required this.backBuilder, this.controller});

  @override
  State<PageFlipBuilder> createState() => _PageFlipBuilderState();
}

class _PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  bool _showFront = true;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.addStatusListener(_updateState);
    widget.controller?.setFlipCallback(flip);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateState(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      setState(() {
        _showFront = !_showFront;
      });
    }
  }

  void flip() {
    if (_showFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPageFlipBuilder(
      animation: _controller,
      showFrontSide: _showFront,
      frontBuilder: widget.frontBuilder,
      backBuilder: widget.backBuilder,
    );
  }
}


class FirstFlipWidget extends StatelessWidget {
  const FirstFlipWidget({
    super.key,
    this.onFlip,
    required this.child,
  });

  final Widget child;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFlip,
      child: child,
    );
  }
}

class SecondFlipWidget extends StatelessWidget {
  final VoidCallback? onFlip;
  final Widget child;

  const SecondFlipWidget({
    super.key,
    this.onFlip,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFlip,
      child: child,
    );
  }
}