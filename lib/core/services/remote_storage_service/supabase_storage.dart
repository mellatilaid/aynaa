import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:atm_app/core/services/remote_storage_service/i_remote_storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseStorage extends IRemoteStorageService<Bucket> {
  final _supabase = Supabase.instance.client;

  @override
  Future<List<FileObject>> deleteFile(
      {required String bucketName, required String fileName}) async {
    final List<FileObject> objects =
        await _supabase.storage.from(bucketName).remove([fileName]);
    return objects;
  }

  @override
  Future<Uint8List> downloadFile({
    required String bucketName,
    required String filePath,
  }) async {
    final Uint8List file = await _supabase.storage.from(bucketName).download(
          filePath,
        );
    return file;
  }

  @override
  Future<String> updateFile(
      {required String bucketName,
      required String filePath,
      required String fileName}) async {
    final file = File(filePath);
    final String path = await _supabase.storage.from(bucketName).update(
          fileName,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
    return path;
  }

  @override
  Future<String> uploadFile(
      {required String bucketName,
      required String filePath,
      required String fileName}) async {
    final file = File(filePath);
    final String fullPath = await _supabase.storage.from(bucketName).upload(
          fileName,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    return fullPath;
  }

  @override
  Future<String> createBucket(String bucketName) async {
    final String bucketId = await _supabase.storage.createBucket(bucketName);

    return bucketId;
  }

  @override
  Future<Bucket> getBucket(String bucketName) async {
    final Bucket bucket = await _supabase.storage.getBucket(bucketName);

    return bucket;
  }

  @override
  Future<String> updateBucket(String bucketName) async {
    final String bucketId = await _supabase.storage
        .updateBucket(bucketName, const BucketOptions(public: false));

    return bucketId;
  }

  @override
  Future<List<Bucket>> getAllBuckets() async {
    final List<Bucket> buckets = await _supabase.storage.listBuckets();

    return buckets;
  }

  @override
  Future<List<FileObject>> getAllFilesInBucket(
      {required String bucketName}) async {
    final List<FileObject> objects =
        await _supabase.storage.from('avatars').list();
    return objects;
  }

  @override
  Future<Bucket> retreiveBucket(String bucketID) async {
    final Bucket bucket = await _supabase.storage.getBucket(bucketID);
    return bucket;
  }

  @override
  Future<String> deleteBucket(String id) async {
    final String res = await _supabase.storage.emptyBucket(id);
    if (res == 'Successfully emptied') {
      final String res = await _supabase.storage.deleteBucket(id);
      log(res);
    }

    return res;
  }

  @override
  Future<String> emptyBucket(String id) async {
    final String res = await _supabase.storage.emptyBucket(id);
    return res;
  }

  @override
  Future<void> deleteFolder(String bucketName, String folderName) async {
    final String folderPath = '$folderName/';

    // Get all files inside the folder
    final response =
        await _supabase.storage.from(bucketName).list(path: folderName);

    if (response.isNotEmpty) {
      // Extract file paths
      List<String> filesToDelete =
          response.map((file) => '$folderPath${file.name}').toList();

      // Delete all files in the folder
      await _supabase.storage.from(bucketName).remove(filesToDelete);
    }
  }

/*Future<String> createBucket(String bucketName) async {
    final String bucketId = await _supabase.storage.createBucket(bucketName);

    return bucketId;
  }

  Future<String> updateBucket(String bucketName) async {
    final String bucketId = await _supabase.storage
        .updateBucket(bucketName, const BucketOptions(public: false));

    return bucketId;
  }

  @override
  Future<List<Bucket>> getAllBuckets(String bucketName) async {
    final List<Bucket> buckets = await _supabase.storage.listBuckets();

    return buckets;
  }

  Future<Bucket> getBucket(String bucketName) async {
    final Bucket bucket = await _supabase.storage.getBucket(bucketName);

    return bucket;
  }*/
}
