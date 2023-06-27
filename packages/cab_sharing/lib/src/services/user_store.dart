class CommonStore {
  Map<String, dynamic> userData;

  CommonStore({required this.userData});

  String get userName => userData['name'] ?? "";
  String get userEmail => userData['email'] ?? "";
  String get securityKey => userData['security-key'] ?? "";

  static const kGuestEmail = "guest_user";
}
