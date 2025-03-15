import 'dart:convert';

import 'package:crypto/crypto.dart';

String encrypteName(String arabicName) {
  var bytes = utf8.encode(arabicName);
  var digest = sha1.convert(bytes);
  return 'bucket_${digest.toString()}';
}
