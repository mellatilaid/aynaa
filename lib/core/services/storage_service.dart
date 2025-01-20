import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class StorageService<T> {
  Future<String> uploadFile(
      {required String bucketName,
      required String filePath,
      required String fileName});
  Future<List<FileObject>> deleteFile(
      {required String bucketName, required String fileName});
  Future<Uint8List> downloadFile(
      {required String bucketName,
      required String filePath,
      required String fileName});
  Future<String> updateFile(
      {required String bucketName,
      required String filePath,
      required String fileName});

  Future<List<FileObject>> getAllFilesInBucket({
    required String bucketName,
  });
  Future<String> createBucket(String bucketName);
  Future<T> retreiveBucket(String bucketID);

  Future<String> updateBucket(String bucketName);

  Future<List<T>> getAllBuckets();

  Future<T> getBucket(String bucketName);
}
