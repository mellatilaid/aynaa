import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Failures {
  final String errMessage;

  Failures({required this.errMessage});
}

class ServerFailure extends Failures {
  ServerFailure({required super.errMessage});

  factory ServerFailure.fromSupaDataBase({required dynamic e}) {
    if (e is PostgrestException) {
      switch (e.code) {
        case '23502': // NOT NULL violation
          return ServerFailure(
              errMessage:
                  'خطأ: قيمة غير مسموح بها لفارغ في أحد الحقول المطلوبة.');
        case '23505': // UNIQUE violation
          return ServerFailure(
              errMessage:
                  'خطأ: البيانات المدخلة موجودة مسبقاً ولا يمكن تكرارها.');
        case '42501': // Insufficient privilege
          return ServerFailure(
              errMessage: 'خطأ: ليست لديك الصلاحية لتنفيذ هذه العملية.');
        case '42P01': // Undefined table
          return ServerFailure(errMessage: 'خطأ: الجدول المطلوب غير موجود.');
        case '42703': // Undefined column
          return ServerFailure(errMessage: 'خطأ: العمود المطلوب غير موجود.');
        case '42601': // Syntax error
          return ServerFailure(errMessage: 'خطأ: هناك مشكلة في بناء الجملة.');
        case '22P02': // Invalid text representation
          return ServerFailure(errMessage: 'خطأ: تنسيق البيانات غير صحيح.');
        case '23503': // Foreign key violation
          return ServerFailure(
              errMessage:
                  'خطأ: البيانات المدخلة مرتبطة بجدول آخر ولا يمكن حذفها.');
        default:
          return ServerFailure(errMessage: 'خطأ غير معروف: ${e.message}');
      }
    } else {
      return ServerFailure(errMessage: 'خطأ غير معروف: ${e.toString()}');
    }
  }

  factory ServerFailure.fromStorage({required StorageException e}) {
    switch (e.message) {
      case 'The resource already exists':
        return ServerFailure(
            errMessage: 'هذا الملف موجود بالفعل , يرجى اختيار ملف اخر');

      default:
        return ServerFailure(
            errMessage: 'Something went wrong, please try later');
    }
  }
}

/*factory ServerFailure.fromAuthException({required FirebaseAuthException e}) {
    if (e.code == 'account-exists-with-different-credential') {
      return ServerFailure(
          errMessage: 'Account exists with different credential');
    } else if (e.code == 'invalid-credential') {
      // Handle invalid or expired credential
      return ServerFailure(errMessage: 'Invalid credential');
    } else if (e.code == 'operation-not-allowed') {
      // Suggest enabling Google Sign-In in Firebase Console
      return ServerFailure(errMessage: 'Operation not allowed');
    } else if (e.code == 'user-disabled') {
      // Notify user their account is disabled
      return ServerFailure(errMessage: 'User disabled');
    } else {
      // General error handler
      return ServerFailure(
          errMessage: 'Something went wrong, please try later');
    }
  }

  factory ServerFailure.fromFireStoreException({required FirebaseException e}) {
    switch (e.code) {
      case 'permission-denied':
        return ServerFailure(errMessage: 'Error: Permission denied.');

      case 'unavailable':
        return ServerFailure(
            errMessage:
                'Error: Firestore is currently unavailable. Please try again later.');

      case 'not-found':
        return ServerFailure(errMessage: 'Document not found.');

      case 'cancelled':
        return ServerFailure(errMessage: 'Operation cancelled.');

      // Add additional cases for other potential errors
      default:
        return ServerFailure(
            errMessage: 'An error occurred. Please try again.');
    }
  }*/
