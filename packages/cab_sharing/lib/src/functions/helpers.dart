String getDayOfMonthSuffix(int dayNum) {
  if(!(dayNum >= 1 && dayNum <= 31)) {
    throw Exception('Invalid day of month');
  }

  if(dayNum >= 11 && dayNum <= 13) {
    return '${dayNum}th';
  }

  switch(dayNum % 10) {
    case 1: return '${dayNum}st';
    case 2: return '${dayNum}nd';
    case 3: return '${dayNum}rd';
    default: return '${dayNum}th';
  }
}
