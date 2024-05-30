import 'package:flutter/material.dart';

/// font size fixation
MediaQueryData getScaleFontSize(BuildContext context,
        {double fontSize = 1.0}) =>
    MediaQuery.of(context).copyWith(textScaleFactor: fontSize);
