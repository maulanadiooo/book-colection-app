import 'dart:math';

import 'package:intl/intl.dart';

String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  final stringBuffer = StringBuffer();

  for (int i = 0; i < length; i++) {
    final randomIndex = random.nextInt(chars.length);
    stringBuffer.write(chars[randomIndex]);
  }

  return stringBuffer.toString().toUpperCase();
}

const String separatorThousand = ',';
NumberFormat formatNumber() {
  // tentukan separator di file constanta.dart
  if (separatorThousand == ',') {
    return NumberFormat('#,###');
  } else if (separatorThousand == '.') {
    return NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);
  } else {
    return NumberFormat('#,###');
  }
}
