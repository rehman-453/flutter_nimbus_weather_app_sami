import 'dart:convert';

// import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// import 'package:nimbus_weather_app/services/api_services/api_endpoints.dart';

class ApiServices {
  // get method for api services
  getMethod(String completeUrl) async {
    http.Response response = await http.get(Uri.parse(completeUrl));
    return returnResponse(response);
  }

  // post method for api services
  postMethod(String completeUrl, Map<String, dynamic> apiBody) async {
    http.Response response = await http.post(
      Uri.parse(completeUrl),
      body: jsonEncode(apiBody),
      headers: {"Content-Type": "application/json"},
    );
    return returnResponse(response);
  }
}

// made for returning the response
returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return response.body;
    case 400:
      throw Exception("Bad request");
    // return Get.snackbar("Error", "Bad Request");
    case 401:
      throw Exception("Unauthorized");
    // throw Get.snackbar("Error", "Unauthorized");
    case 403:
      throw Exception("Unauthorized");
    case 404:
      throw Exception("Not Found");
    case 500:
      throw Exception("Internal Server Error");
    default:
      final responseData = jsonDecode(response.body);

      final errorMessage =
          responseData['error']?['message'] ??
          "Error occurred with StatusCode: ${response.statusCode}";

      throw Exception(errorMessage);
  }
}

// returnResponse(http.Response response) {
//   switch (response.statusCode) {
//     case 200:
//       return response.body;
//     case 400:
//       throw Exception("Bad request");
//     // return Get.snackbar("Error", "Bad Request");
//     case 401:
//       throw Exception("Unauthorized");
//     // throw Get.snackbar("Error", "Unauthorized");
//     case 403:
//       throw Exception("Unauthorized");
//     case 404:
//       throw Exception("Not Found");
//     case 500:
//       throw Exception("Internal Server Error");
//     default:
//       throw Exception(
//         "Error occurred while Communication with Server with StatusCode: ${response.statusCode}",
//       );
//   }
// }
