import 'package:flutter/material.dart';
import 'package:urine/layers/presentation/widget/w_arrow.dart';
import 'package:urine/layers/presentation/widget/w_rounded_container.dart';
import 'package:urine/layers/presentation/widget/w_tap.dart';

class BigButton extends StatelessWidget {
  final String text;
  final double height;
  final Function() onTap;

  const BigButton(
    this.text, {
    super.key,
    required this.onTap,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: RoundedContainer(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Arrow()
          ],
        ),
      ),
    );
  }
}
