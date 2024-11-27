import 'package:intl/intl.dart';

bool hasAnyRtl(String text) {
  /*final bool hasRtl = Bidi.hasAnyRtl(text);
  return hasRtl;*/
  if (text.isNotEmpty) {
    final bool hasRtl = Bidi.hasAnyRtl(text);
    if (hasRtl) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
