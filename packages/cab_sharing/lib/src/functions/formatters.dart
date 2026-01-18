// Shared formatting functions for cab sharing module

/// Formats location string for display (short form)
String formatLocationShort(String location) {
  if (location.toLowerCase().contains('iit')) return 'Campus';
  if (location.toLowerCase().contains('airport')) return 'Airport';
  if (location.toLowerCase().contains('guwahati') &&
      location.toLowerCase().contains('station')) {
    return 'GHY Station';
  }
  if (location.toLowerCase().contains('kamakhya')) return 'Kamakhya';
  return location.length > 10 ? '${location.substring(0, 10)}...' : location;
}

/// Formats note/description for display
String formatNote(String note) {
  if (note.isEmpty) return 'No notes';
  final cleaned = note.replaceAll('\n', ' ').trim();
  return cleaned.length > 40 ? '${cleaned.substring(0, 40)}...' : cleaned;
}

/// Formats user name for display
String formatName(String name) {
  return name.length > 15 ? '${name.substring(0, 15)}...' : name;
}

/// Formats date for display
String formatDate(String date) {
  return date.length > 12 ? '${date.substring(0, 12)}...' : date;
}

/// Formats status/margin text for display
String formatStatus(String status) {
  if (status.contains('Can leave upto 1 hr')) return '1h early';
  if (status.contains('Can leave upto 2 hr')) return '2h early';
  if (status.contains('exact time')) return 'On time';
  return status.length > 15 ? '${status.substring(0, 15)}...' : status;
}

/// Determines if travel is by train based on destination
bool isTravelByTrain(String destination) {
  final lower = destination.toLowerCase();
  return lower.contains('railway') ||
      lower.contains('station') ||
      lower.contains('kamakhya');
}
