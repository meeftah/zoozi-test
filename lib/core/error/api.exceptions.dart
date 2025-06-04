class ApiExceptions implements Exception {
  final String message;
  final String prefix;

  ApiExceptions([this.message = "", this.prefix = ""]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends ApiExceptions {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends ApiExceptions {
  BadRequestException(String message) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends ApiExceptions {
  UnauthorizedException(String message) : super(message, "Unauthorized: ");
}

class ForbiddenException extends ApiExceptions {
  ForbiddenException(String message) : super(message, "Forbidden: ");
}

class NotFoundException extends ApiExceptions {
  NotFoundException(String message) : super(message, "Not Found: ");
}

class InternalServerException extends ApiExceptions {
  InternalServerException(String message) : super(message, "Internal Server: ");
}

class UnprocessableContentException extends ApiExceptions {
  UnprocessableContentException(String message)
      : super(message, "Unprocessable Content: ");
}

class InvalidInputException extends ApiExceptions {
  InvalidInputException(String message) : super(message, "Invalid Input: ");
}