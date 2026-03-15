class Endpoints {
  static const baseUrl = String.fromEnvironment('SERVER_URL');
  static const apiSecurityKey = String.fromEnvironment('SECURITY_KEY');
  static const cabSharingURL = "/campus-travel";
  static const cabSharingMyAdsURL = "/campus-travel/myads";
  static const cabSharingChatURL = "/campus-travel/chat";
  static const cabSharingAllURL = "/campus-travel/all";
  static const cabSharingRequestToJoinURL = "/campus-travel/request-to-join";

  // Accept booking uses path params: /campus-travel/:postId/bookings/:bookingId/accept
  static String cabSharingAcceptBookingURL(String postId, String bookingId) =>
      "/campus-travel/$postId/bookings/$bookingId/accept";

  static getHeader() {
    return {
      'Content-Type': 'application/json',
      'security-key': Endpoints.apiSecurityKey,
    };
  }
}
