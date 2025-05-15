class ErrorHandler {
  static String handleError(dynamic error) {
    if (error is Exception) return error.toString();
    return 'Ocorreu um erro inesperado';
  }
}
