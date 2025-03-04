abstract class INetworkStateService {
  Future<bool> isDeviceConnected();

  // Check if there's actual internet access (not just a network connection)
  Future<bool> hasInternetAccess();

  // Combine checks
  Future<bool> isOnline();
}
