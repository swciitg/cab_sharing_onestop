String timeHelper(Map<String, int> data) {
  String answer = "";
  answer += "${data['year']! + 2022}-";
  int month = data['month']! + 1;
  if (month < 10) {
    answer += "0";
  }
  answer += "$month-";
  int date = data['date']! + 1;
  if (date < 10) {
    answer += "0";
  }
  answer += "${date}T";
  int hour = data['hour']!;
  if (hour < 10) {
    answer += "0";
  }
  answer += "$hour:";
  int min = data['min']!;
  if (min < 10) {
    answer += "0";
  }
  answer += "$min:";
  return "${answer}00.000000";
}
