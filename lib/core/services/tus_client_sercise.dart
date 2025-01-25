import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tus_client_dart/tus_client_dart.dart';

class TusClientManager {
  static final TusClientManager _instance = TusClientManager._internal();

  factory TusClientManager() {
    return _instance;
  }

  TusClientManager._internal();

  TusClient? _client;

  /// Initialize the TusClient
  void initialize(XFile file, String uid) {
    final tempDir = getTemporaryDirectory();
    final tempDirectory = Directory('$tempDir/${file.name}_uploads');
    if (!tempDirectory.existsSync()) {
      tempDirectory.createSync(recursive: true);
    }

    _client = TusClient(
      file,
      store: TusFileStore(tempDirectory),
      maxChunkSize: 1024 * 1024 * 6,
      retries: 10,
      retryInterval: 2,
      retryScale: RetryScale.exponential,
    );
  }

  /// Upload a file
  Future<void> upload(String uploadUrl, Map<String, String> metadata,
      Function onProgress, Function onComplete, Function onError) async {
    if (_client == null) {
      throw Exception("TusClient not initialized");
    }

    try {
      await _client!.upload(
        uri: Uri.parse(uploadUrl),
        metadata: metadata,
        headers: {
          'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
          'x-upsert': 'true',
        },
        onProgress: (progress, estimate) {
          onProgress(progress, estimate);
        },
        onComplete: () {
          onComplete();
        },
      );
    } catch (e) {
      onError(e.toString());
    }
  }

  /// Pause the upload
  void pauseUpload() {
    if (_client == null) {
      throw Exception("TusClient not initialized");
    }
    _client!.pauseUpload();
  }

  /// Cancel the upload
  Future<void> cancelUpload() async {
    if (_client == null) {
      throw Exception("TusClient not initialized");
    }
    await _client!.cancelUpload();
  }

  /// Get the shared instance
  static TusClientManager get instance => _instance;
}
