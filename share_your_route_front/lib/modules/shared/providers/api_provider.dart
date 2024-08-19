import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:share_your_route_front/modules/shared/providers/http_requests_provider.dart";

final apiUrl = dotenv.env["API_URL"];

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

Future<Map<String, dynamic>?> getRouteById(String routeId) async {

  final getRouteUrl = "routes/${routeId}";
  final data = await getRequest("$apiUrl$getRouteUrl") as Map<String, dynamic>?;
  print("$apiUrl$getRouteUrl");
  
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

Future<Map<String, dynamic>> getUserData(String userId) async {
  final response = await getRequest("${apiUrl}users/$userId");
  return response as Map<String, dynamic>;
}

Future updateUserData(String userId, Map<String, dynamic> userData) async {
  final response = await putRequest("${apiUrl}users/$userId", userData);
  return response;
}

Future registerUser(Map<String, dynamic> userData) async {
  final response = await postRequest("${apiUrl}auth/register", userData);
  return response;
}
