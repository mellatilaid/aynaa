import 'package:atm_app/const.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDb extends DataBase {
  final _supabase = Supabase.instance.client;
  @override
  Future<bool> checkIfUserExistInDB(
      {required String path, required String uID}) async {
    final data =
        await _supabase.from(path).select().eq(kUuid, uID).maybeSingle();

    if (data == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> deleteData({required String path, required String uid}) async {
    await _supabase.from(path).delete().eq(kUuid, uid);
  }

  @override
  Future getDate(
      {required String path, String? uID, Map<String, dynamic>? query}) async {
    if (uID == null && query == null) {
      final List<Map<String, dynamic>> data =
          await _supabase.from(path).select();
      return data;
    }
    if (query != null) {
      if (query.length > 1) {
        var queryBuilder = _supabase.from(path).select();

        // Apply filters for each key-value pair in the query map
        query.forEach((key, value) {
          queryBuilder = queryBuilder.eq(key, value);
        });
        // Fetch and return the filtered data
        final List<Map<String, dynamic>> data = await queryBuilder;
        return data;
      }
      final List<Map<String, dynamic>> data = await _supabase
          .from(path)
          .select()
          .eq(query.keys.first, query.values.first);
      return data;
    }

    final Map<String, dynamic> data =
        await _supabase.from(path).select().eq(kUuid, uID!).single();
    return data;
  }

  @override
  Future<void> setDate(
      {required String path,
      required Map<String, dynamic> data,
      String? documentUid}) async {
    await _supabase.from(path).insert(data);
  }

  @override
  Future<void> updateData(
      {required String path,
      required String uid,
      required Map<String, dynamic> data}) async {
    await _supabase.from(path).update(data).eq(kUuid, uid);
  }
}
