abstract class Failures {
  final String errMessage;

  Failures({required this.errMessage});
}

class ServerFailure extends Failures {
  ServerFailure({required super.errMessage});

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
}
