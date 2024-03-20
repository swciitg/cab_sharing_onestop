class Endpoints {
  static const baseUrl = String.fromEnvironment('SERVER-URL');
  static const apiSecurityKey = String.fromEnvironment('SECURITY-KEY');
  static const cabSharingURL = "/campus-travel";
  static const cabSharingMyAdsURL = "/campus-travel/myads";
  static const cabSharingChatURL = "/campus-travel/chat";
  static const cabSharingAllURL = "/campus-travel/all";

  static getHeader() {
    return {'Content-Type': 'application/json', 'security-key': Endpoints.apiSecurityKey};
  }
}