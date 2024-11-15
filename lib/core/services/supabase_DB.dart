import 'package:atm_app/const.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDb extends DataBase {
  final _supabase = Supabase.instance.client;
  @override
  Future<bool> checkIfUserExistInDB(
      {required String path, required String uID}) async {
    final data =
        await _supabase.from(path).select().eq(kUserID, uID).maybeSingle();

    if (data == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> deleteData({required String path, required String uid}) async {
    await _supabase.from(path).delete().eq(kUserID, uid);
  }

  @override
  Future getDate(
      {required String path, String? uID, Map<String, dynamic>? query}) async {
    if (uID == null) {
      final List<Map<String, dynamic>> data =
          await _supabase.from(path).select();
      return data;
    }
    final Map<String, dynamic> data =
        await _supabase.from(path).select().eq(kUserID, uID).single();
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
    await _supabase.from(path).update(data).eq(kUserID, uid);
  }
}
