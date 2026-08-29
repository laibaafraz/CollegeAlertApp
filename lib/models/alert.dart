// A simple model class that represents one college alert/event.
// Beginner note: this is just a plain Dart class to hold data,
// it doesn't need to extend anything special.
class Alert {
  String title;
  String description;
  String date;

  Alert({
    required this.title,
    required this.description,
    required this.date,
  });
}
