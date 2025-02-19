import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult.first == ConnectivityResult.mobile ||
      connectivityResult.first == ConnectivityResult.wifi) {
    return true; // Device is connected to the internet
  } else {
    return false; // No internet connection
  }
}
