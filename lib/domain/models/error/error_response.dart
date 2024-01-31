class ErrorResponseModel {
  final Map<String, dynamic> errors;
  final String? firstError;

  ErrorResponseModel({required this.errors, this.firstError});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(errors: json['errors']);
}
