
class Payment {
  final String id;
  final String patientName;
  final double amount;
  final String method;
  final String status;
  final String date;

  const Payment({
    required this.id,
    required this.patientName,
    required this.amount,
    required this.method,
    required this.status,
    required this.date,
  });
}