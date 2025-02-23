import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkStateService extends INetworkStateService {
  @override
  Future<bool> hasInternetAccess() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<bool> isDeviceConnected() async {
    try {
      const timeout = Duration(seconds: 5);
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(timeout); // Ping Google
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> isOnline() async {
    final isConnected = await isDeviceConnected();
    if (!isConnected) return false;
    return await hasInternetAccess();
  }
}
