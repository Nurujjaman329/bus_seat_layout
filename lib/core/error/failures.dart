// Custom exception classes for better error handling
abstract class Failure implements Exception {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class DataParsingFailure extends Failure {
  const DataParsingFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

// Extension to convert failures to user-friendly messages
extension FailureMessage on Failure {
  String toUserMessage() {
    if (this is NetworkFailure) {
      return 'Network connection issue. Please check your internet connection and try again.';
    } else if (this is ServerFailure) {
      return 'Server is temporarily unavailable. Please try again later.';
    } else if (this is DataParsingFailure) {
      return 'Data format error. Please contact support if this continues.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}