import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:matrix_effect/widgets/vertical_text_line.dart';

class MatrixEffect extends StatefulWidget {
  const MatrixEffect({Key? key}) : super(key: key);

  @override
  _MatrixEffectState createState() => _MatrixEffectState();
}

class _MatrixEffectState extends State<MatrixEffect> {
  final List<Widget> _verticalLines = [];

  late Timer timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _verticalLines,
    );
  }

  void _startTimer() {
    timer = Timer.periodic(
      const Duration(
        milliseconds: 300,
      ),
      (timer) {
        setState(
          () {
            _verticalLines.add(
              _getVerticalLines(context),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget _getVerticalLines(BuildContext context) {
    Key key = GlobalKey();
    return Positioned(
      key: key,
      left: Random().nextDouble() * MediaQuery.of(context).size.width,
      child: VerticalTextLine(
        onFinished: () {
          setState(
            () {
              _verticalLines.removeWhere((element) => element.key == key);
            },
          );
        },
        speed: 1 + Random().nextDouble() * 9,
        maxLength: Random().nextInt(10) + 5,
      ),
    );
  }
}
