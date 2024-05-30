import 'package:urine/common/data/preference/item/nullable_preference_item.dart';
import 'package:urine/common/theme/custom_theme.dart';

import 'item/preference_item.dart';

class Prefs {
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');

  static final userID = PreferenceItem<String>('userID', '');
  static final password = PreferenceItem<String>('password', '');
  static final token = PreferenceItem<String>('token', '');
  static final toggelGatt = PreferenceItem<bool>('toggelGatt', false);
}
