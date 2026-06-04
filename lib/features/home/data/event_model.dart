class EventModel {
  final String title;
  final String amount;
  final String category;
  final String timeLeft;
  final String imagePath;
  final bool isUrgent;
  final String status;
  final String actionText; 

  EventModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.timeLeft,
    required this.imagePath,
    this.isUrgent = false,
    required this.status,
    required this.actionText,
  });
}