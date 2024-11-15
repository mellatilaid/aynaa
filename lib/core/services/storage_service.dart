abstract class StorageService {
  Future<String> uploadFile({required String path, required String fileName});
  Future<void> deleteFile({required String path, required String fileName});
  Future<void> downloadFile({required String path, required String fileName});
  Future<void> updateFile({required String path, required String fileName});
}
