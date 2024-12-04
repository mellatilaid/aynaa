import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/aynaa_versions_entity.dart';

class AynaaVersionsModel extends AynaaVersionsEntity {
  final String aynaaVersion;

  @override
  final String id;

  AynaaVersionsModel(this.id, {required this.aynaaVersion})
      : super(versionName: aynaaVersion, id: id);

  factory AynaaVersionsModel.fromSupabase(Bucket bucket) {
    return AynaaVersionsModel(bucket.id, aynaaVersion: bucket.name);
  }
}
