abstract class DataBase {
  Future<dynamic> getDate({
    required String path,
    String? uID,
    Map<String, dynamic>? query,
  });
  Future<void> setDate({
    required String path,
    required Map<String, dynamic> data,
    String? documentUid,
  });
  Future<bool> checkIfUserExistInDB(
      {required String path, required String uID});
  Future<void> deleteData({required String path, required String uid});
  Future<void> updateData({
    required String path,
    required String uid,
    required Map<String, dynamic> data,
  });
}