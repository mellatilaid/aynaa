import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../const/remote_db_const.dart';

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
  Future getData({
    required String path,
    String? uID,
    Map<String, dynamic>? query,
    String? columns,
    FilterComparison? filterComparison,
  }) async {
    if (uID == null && query == null) {
      final List<Map<String, dynamic>> data =
          await _supabase.from(path).select(columns ?? '*');
      return data;
    }
    if (query != null) {
      if (query.keys.length > 1) {
        var queryBuilder = _supabase.from(path).select();

        // Apply filters for each key-value pair in the query map
        switch (filterComparison) {
          case FilterComparison.equal:
            query.forEach((key, value) {
              queryBuilder = queryBuilder.eq(key, value);
            });
            break;
          case FilterComparison.greaterThan:
            query.forEach((key, value) {
              queryBuilder = queryBuilder.gt(key, value);
            });
            break;

          default:
            query.forEach((key, value) {
              queryBuilder = queryBuilder.eq(key, value);
            });
        }

        // Fetch and return the filtered data
        final List<Map<String, dynamic>> data = await queryBuilder;
        return data;
      }
      switch (filterComparison) {
        case FilterComparison.equal:
          final List<Map<String, dynamic>> data = await _supabase
              .from(path)
              .select()
              .eq(query.keys.first, query.values.first);
          return data;

        case FilterComparison.greaterThan:
          final List<Map<String, dynamic>> data = await _supabase
              .from(path)
              .select()
              .gt(query.keys.first, query.values.first);
          return data;

        default:
          final List<Map<String, dynamic>> data = await _supabase
              .from(path)
              .select()
              .eq(query.keys.first, query.values.first);
          return data;
      }
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

  @override
  Future<void> callingrpcFuc(
      {required String functionName,
      required Map<String, dynamic> params}) async {
    // TODO: implement callingrpcFuc
    await _supabase.rpc(functionName, params: params);
  }
}
