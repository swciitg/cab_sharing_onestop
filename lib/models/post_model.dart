class Post {
  static const int RAILWAY = 0;
  static const int AIRWAY = 1;

  static const int EXACT = 0;
  static const int ONE_HOUR = 1;
  static const int TWO_HOUR = 2;

  String name;
  String email;
  String time;
  int mode;
  int note;

  Post(
      {required this.name,
      required this.email,
      required this.time,
      required this.mode,
      required this.note});

  String getNote () {
    switch (note) {
      case EXACT:
        return "Can leave exactly at this time.";
      case ONE_HOUR:
        return "Can leave upto 1 hr early.";
      default:
        return "Can leave upto 2 hr early.";
    }
  }
}
