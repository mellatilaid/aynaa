import 'package:isar/isar.dart';

part 'deleted_itmes_entity.g.dart';

@Collection()
class DeletedItmesEntity {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  final String itemID;
  final bool isVersion;
  final bool isCompleted;

  DeletedItmesEntity(this.itemID, this.isVersion, this.isCompleted);
}
