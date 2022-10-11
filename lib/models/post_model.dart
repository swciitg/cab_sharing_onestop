class Post {
  static const int railway = 0;
  static const int airway = 1;

  static const int exact = 0;
  static const int oneHour = 1;
  static const int twoHour = 2;

  String name;
  String email;
  String time;
  int mode;
  int note;

  Post({
    required this.name,
    required this.email,
    required this.time,
    required this.mode,
    required this.note,
  });

  String getNote() {
    switch (note) {
      case exact:
        return "Can leave exactly at this time.";
      case oneHour:
        return "Can leave upto 1 hr early.";
      default:
        return "Can leave upto 2 hr early.";
    }
  }
}
