import "package:share_your_route_front/modules/shared/providers/http_requests_provider.dart";

const apiUrl = "https://shareyourroute-back.onrender.com/api/";

Future createAccount(Map<String, String> userJson) async {
  final response = await postRequest("${apiUrl}auth/register", userJson);
  return response;
}

Future<List<Map<String, dynamic>>> getAllRoutes() async {
  const getRoutesUrl = "routes/all";
  final List<dynamic> dataFirst =
      await getRequest("$apiUrl$getRoutesUrl") as List<dynamic>;
  final List<Map<String, dynamic>> data =
      List<Map<String, dynamic>>.from(dataFirst);
  return data;
}

Future getPublicRoutes() {
  const getRoutesUrl = "routes/all/public";
  return getRequest("$apiUrl$getRoutesUrl");
}

Future getPrivateRoutes() {
  const getRoutesUrl = "routes/all/private";
  return getRequest("$apiUrl$getRoutesUrl");
}

Future saveRoute(Map<String, dynamic> routeJson) async {
  final response = await postRequest("${apiUrl}routes/save", routeJson);
  return response;
}

Future getUserData(String userId) async {
  final response = await getRequest("${apiUrl}users/$userId");
  return response;
}

Future updateUserData(String userId, Map<String, dynamic> userData) async {
  final response = await putRequest("${apiUrl}users/$userId", userData);
  return response;
}