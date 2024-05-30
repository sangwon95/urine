

import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate => DateFormat('yyyy.MM.dd').format(this);

  String get formattedTime => DateFormat('HH:mm').format(this);

  String get formattedDateTime => DateFormat('yy.MM.dd').format(this);

  String get formattedCalender => DateFormat('MM.dd EEEE').format(this);
  String get formattedClean => DateFormat('yyyyMMdd').format(this);
}
