import 'package:atm_app/core/entities/entitiy.dart';

class ExamEntity with Entity {
  @override
  final String entityID;
  final String title;
  @override
  final String versionName;
  @override
  final String? url;
  @override
  String? localFilePath;
  ExamEntity({
    required this.entityID,
    required this.title,
    required this.versionName,
    required this.url,
    required this.localFilePath,
  });

  @override
  // TODO: implement name
  String? get name => title;
}
