import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double size;

  const LoadingWidget({
    super.key,
    this.color,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: Colors.red,
        size: size,
      ),
    );
  }
}