extension TitleCase on String {
  String toTitleCase() {
    if (isEmpty) return this;
    var l = split(' ');
    for (int i = 0; i < l.length; i++) {
      l[i] = '${l[i][0].toUpperCase()}${l[i].substring(1).toLowerCase()}';
    }
    return l.join(" ");
  }
}
