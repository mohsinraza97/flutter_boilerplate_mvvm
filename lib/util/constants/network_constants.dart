class NetworkConstants {
  const NetworkConstants._internal();

  static const String baseUrl = 'https://mohsinraza10p-task-manager.herokuapp.com/';

  // Endpoints
  static const String register = 'users';
  static const String login = 'users/login';

  // {
  //   "success": true,
  //   "message": null,
  //   "data": null
  // }
  static const String successResponseStart = "{    \"success\":true,    \"message\":null,    \"data\":";
  static const String successResponseEnd = " }";
}
