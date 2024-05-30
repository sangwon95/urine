

import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';

class HomeBackgroundLayout extends StatelessWidget {
  final Widget child;

  const HomeBackgroundLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: AppConstants.radius,
            bottomRight: AppConstants.radius,
          ),
          gradient: AppConstants.gradient,
      ),
      child: child,
    );
  }


}
