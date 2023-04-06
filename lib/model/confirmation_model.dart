class ConfirmationModel {
  String requestCode;
  String confirmCode;
  String date;
  ConfirmationModel({
    required this.requestCode,
    required this.confirmCode,
    required this.date,
  });
}
